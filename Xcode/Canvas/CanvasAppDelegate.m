//
//  CanvasAppDelegate.m
//  Canvas
//
//  Created by David Schwartz on 2014-01-08.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import "CanvasAppDelegate.h"

const char *arduinoPort = "/dev/cu.usbmodemfa131";

@implementation CanvasAppDelegate

#pragma mark APPLICATION METHODS

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.simulatorView setHorizontalCells:8 VerticalCells:4];
    self.simulatorView.currentPattern = [[CanvasPattern alloc] initWithWidth:8 Height:4 Length:1];
    [self.simulatorView.currentPattern clearPatternToWhite];
    // note: frameSlider initialized in nib
    self.timer = nil;
}

#pragma mark CONTROLLER METHODS

- (void) timerEventHandler
{
    self.simulatorView.currentTime ++;
    self.simulatorView.currentTime %= self.simulatorView.currentPattern.length;
    [self.simulatorView drawFrame];
    [self.frameSlider setIntegerValue:self.simulatorView.currentTime];
}

- (IBAction)tempoFieldAction:(id)sender
{
    
}

- (IBAction)pauseButtonAction:(id)sender
{
    [self.timer invalidate];
    self.timer = nil;
    [self.frameSlider setIntegerValue:self.simulatorView.currentTime];
    [self.playButton setState:NSOffState];
}

- (IBAction)playButtonAction:(id)sender
{
    CGFloat interval = 1.0f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
}

- (IBAction)frameSliderAction:(NSSlider*)sender
{
    if (self.timer != nil)
    {
        [self.timer invalidate];
        self.timer = nil;
        [self.playButton setState:NSOffState];
    }
    self.simulatorView.currentTime = self.frameSlider.integerValue;
    [self.simulatorView drawFrame];
}

- (IBAction)openPatternAction:(id)sender
{
    if (self.timer != nil)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    
    [openPanel beginWithCompletionHandler:^(NSInteger result)
    {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL *patternURL = [[openPanel URLs] objectAtIndex:0];
            NSData *patternData = [[NSFileManager defaultManager] contentsAtPath:[patternURL path]];
            CanvasPattern* newPattern = [[CanvasPattern alloc] initWithData:patternData];
            
            if (newPattern == nil)
            {
                // handle error
            }
            else
            {
                self.simulatorView.currentPattern = newPattern;
                [self.simulatorView setHorizontalCells:newPattern.width VerticalCells:newPattern.height];
                self.simulatorView.currentTime = 0;
                [self.simulatorView drawFrame];
                
                [self.frameSlider setIntegerValue:0];
                [self.frameSlider setNumberOfTickMarks:newPattern.length];
                [self.frameSlider setMaxValue:newPattern.length - 1];
            }
        }
    }];
}

- (IBAction)savePatternAction:(id)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setAllowedFileTypes:[NSArray arrayWithObject:@"canvas"]];
    [savePanel setNameFieldStringValue:@"pattern"];
    
    [savePanel beginWithCompletionHandler:^(NSInteger result)
    {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL* url = [savePanel URL];
            NSString* path = [url path];
            [self.simulatorView.currentPattern savePatternToFileAtPath:path];
        }
    }];
}

- (IBAction)uploadPatternAction:(id)sender
{
    // http://playground.arduino.cc/Interfacing/Cocoa
    
    NSData *patternData = [self.simulatorView.currentPattern convertPatternToData];
    uint8_t *patternBytes = (uint8_t*) [patternData bytes];
    const long sizeOfData = [patternData length];
    
    NSLog(@"bytes to send:");
    for (int i = 0; i < sizeOfData; i++) {
        NSLog(@"%d", patternBytes[i]);
    }
    
    struct termios options;
    speed_t baudRate = B9600;
    
    bool __block completionFlag = false;
    
    // close serial port if open
	if (serialFileDescriptor != -1) {
		close(serialFileDescriptor);
		serialFileDescriptor = -1;
        
        usleep(5000000);
	}
    
    // open the serial like POSIX C
    serialFileDescriptor = open(
                                arduinoPort,
                                O_RDWR |
                                O_NOCTTY |
                                O_NONBLOCK );
    
    NSLog(@"serialFileDescriptor: %d", serialFileDescriptor);
    
    // block non-root users from using this port
    ioctl(serialFileDescriptor, TIOCEXCL);
    
    // clear the O_NONBLOCK flag, so that read() will block and wait for data.
    fcntl(serialFileDescriptor, F_SETFL, 0);
    
    // grab the options for the serial port
    tcgetattr(serialFileDescriptor, &options);
    
    // setting raw-mode allows the use of tcsetattr() and ioctl()
    cfmakeraw(&options);
    tcsetattr(serialFileDescriptor, TCSANOW, &options);
    
    // specify baud rate
    ioctl(serialFileDescriptor, IOSSIOSPEED, &baudRate);
    
    // read serial input
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        uint8_t byte_buffer[100]; // buffer for holding incoming data
        long numBytes = 1; // number of bytes read during read
        int byteCounter = 0; // the total number of bytes read
        
        // this will loop until the serial port closes
        while(numBytes>0) {
            // read() blocks until data is read or the port is closed
            numBytes = read(serialFileDescriptor, byte_buffer, 100);
            
            if (numBytes >=1)
                byteCounter += numBytes;
            
            for (int i = 0; i < numBytes; i++) {
                uint8_t data = byte_buffer[i];
                NSLog(@"%d", data);
            }
            
            if (byteCounter >= sizeOfData)
            {
                completionFlag = true;
            
                // make sure the serial port is closed
                if (serialFileDescriptor != -1) {
                    close(serialFileDescriptor);
                    serialFileDescriptor = -1;
                }
            }
        }
    });
    
    usleep(5000000);
    
    // write data
    write(serialFileDescriptor, patternBytes, sizeOfData);
    
    // block until arduino signals that the process is finished
    while (true)
    {
        if (completionFlag) break;
        usleep(50);
    }
    
    // make sure the serial port is closed
	if (serialFileDescriptor != -1) {
		close(serialFileDescriptor);
		serialFileDescriptor = -1;
	}
}

@end

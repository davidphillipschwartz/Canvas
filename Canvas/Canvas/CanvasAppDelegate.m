//
//  CanvasAppDelegate.m
//  Canvas
//
//  Created by David Schwartz on 2014-01-08.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import "CanvasAppDelegate.h"

@implementation CanvasAppDelegate

#pragma mark APPLICATION METHODS

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"didFinishLaunching");
    [self.simulatorView setHorizontalCells:5 VerticalCells:5];
    
    /*
    currentPattern = [[CanvasPattern alloc] initWithWidth:9 Height:9 Length:5];
    [currentPattern initializeWithDefaultPattern];
    [self createPatternFileWithData:[currentPattern convertPatternToData]];
    
    NSString *documentsDirectory;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        documentsDirectory = paths[0];
    }
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"David/Canvas/testFile.canvas"];

    currentPattern = [[CanvasPattern alloc] initWithData:[[NSFileManager defaultManager] contentsAtPath:filePath]];
    */
    
    self.simulatorView.currentPattern = nil;
    
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

- (void) createPatternFileWithData:(NSData*)data
{
    NSString *documentsDirectory;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        documentsDirectory = paths[0];
    }
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"David/Canvas/testFile.canvas"];
    bool success = [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    #pragma unused(success)
    NSAssert(success, @"ERROR CREATING PATTERN FILE");
}

- (IBAction)tempoFieldAction:(id)sender
{
    
}

- (IBAction)pauseButtonAction:(id)sender
{
    [self.timer invalidate];
    self.timer = nil;
    self.simulatorView.currentTime = 0;
    [self.frameSlider setIntegerValue:0];
    [self.simulatorView drawFrame];
    [self.playButton setState:NSOffState];
}

- (IBAction)playButtonAction:(id)sender
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
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
                [self.frameSlider setNumberOfTickMarks:newPattern.length];
                [self.frameSlider setMaxValue:newPattern.length - 1];
            }
        }
    }];
}

- (IBAction)savePatternAction:(id)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    
    [savePanel beginWithCompletionHandler:^(NSInteger result)
    {
        
    }];
}

@end

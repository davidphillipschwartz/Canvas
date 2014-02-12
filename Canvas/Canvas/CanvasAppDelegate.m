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
    [self.simulatorView setHorizontalCells:9 VerticalCells:9];
    
    currentPattern = [[CanvasPattern alloc] initWithWidth:9 Height:9 Length:5];
    
    [self initializePattern];
    
    [self createPatternFileWithData:[currentPattern convertPatternToData]];
    
    NSString *documentsDirectory;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        documentsDirectory = paths[0];
    }
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"David/Canvas/testFile.canvas"];
    
    currentPattern = [[CanvasPattern alloc] initWithData:[[NSFileManager defaultManager] contentsAtPath:filePath]];
    
    timestepCounter = 0;
    
    self.timer = nil;
}

#pragma mark CONTROLLER METHODS

- (void) timerEventHandler
{
    for(int x = 0; x < 9; x++)
    {
        for (int y = 0; y < 9; y++)
        {
            NSColor *pixelColour = [currentPattern getColourAtLocationX:x LocationY:y Time:timestepCounter];
            [self.simulatorView setColour:pixelColour AtLocationX:x LocationY:y];
        }
    }
    timestepCounter++;
    timestepCounter = timestepCounter % 5;
}

- (void) initializePattern
{
    NSColor* colourArray[5];
    colourArray[0] = [NSColor purpleColor];
    colourArray[1] = [NSColor blueColor];
    colourArray[2] = [NSColor purpleColor];
    colourArray[3] = [NSColor blueColor];
    colourArray[4] = [NSColor redColor];
    
    // time = 0
    for (int t = 0; t < 5; t++)
    {
        for(int x = 0; x < 9; x++)
        {
            for (int y = 0; y < 9; y++)
            {
                if (x == 0 || x == 8 || y == 0 || y == 8) {
                    [currentPattern setColour:colourArray[t] AtLocationX:x LocationY:y Time:t];
                }
                else if (x == 1 || x == 7 || y == 1 || y ==7) {
                    [currentPattern setColour:colourArray[(t+1)%5] AtLocationX:x LocationY:y Time:t];
                }
                else if (x == 2 || x == 6 || y == 2 || y == 6) {
                    [currentPattern setColour:colourArray[(t+2)%5] AtLocationX:x LocationY:y Time:t];
                }
                else if (x == 3 || x == 5 || y == 3 || y == 5) {
                    [currentPattern setColour:colourArray[(t+3)%5] AtLocationX:x LocationY:y Time:t];
                }
                else {
                    [currentPattern setColour:colourArray[(t+4)%5] AtLocationX:x LocationY:y Time:t];
                }
            }
        }
    }
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

- (IBAction)pauseButton:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
    timestepCounter = 0;
    [self.playButton setState:NSOffState];
}

- (IBAction)playButton:(id)sender {
    timestepCounter = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
}
@end

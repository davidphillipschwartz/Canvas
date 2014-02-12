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
    
    currentPattern = nil;
    
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
    timestepCounter = 0;
    [self.playButton setState:NSOffState];
}

- (IBAction)playButtonAction:(id)sender
{
    timestepCounter = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
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
            currentPattern = [[CanvasPattern alloc] initWithData:[[NSFileManager defaultManager] contentsAtPath:[patternURL path]]];
            
            if (currentPattern == nil)
            {
                // handle error
            }
            else
            {
                [self.simulatorView setHorizontalCells:currentPattern.width VerticalCells:currentPattern.height];
            }
        }
    }];
}

- (IBAction)colourWellAction:(id)sender {
}

@end

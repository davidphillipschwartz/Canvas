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
    simulatorView = [[CanvasArrayView alloc] initWithX:0.0f Y:0.0f CellWidth:50.0f CellHeight:50.0f HorizontalCells:9 VerticalCells:9];
    [self.window.contentView addSubview:simulatorView];
    
    currentPattern = [[CanvasPattern alloc] initWithWidth:9 Height:9 Length:2];
    
    [self initializePattern];
    
    [self createPatternFileWithData:[currentPattern convertPatternToData]];
    
    NSString *documentsDirectory;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        documentsDirectory = paths[0];
    }
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"David/Canvas/testFile.canvas"];
    currentPattern = [[CanvasPattern alloc] initWithData:[[NSFileManager defaultManager] contentsAtPath:filePath]];
    
    frameCounter = 0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
}

#pragma mark CONTROLLER METHODS

- (void) timerEventHandler
{
    for(int x = 0; x < 9; x++)
    {
        for (int y = 0; y < 9; y++)
        {
            NSColor *pixelColour = [currentPattern getColourAtLocationX:x LocationY:y Time:frameCounter];
            [simulatorView setColour:pixelColour AtLocationX:x LocationY:y];
        }
    }
    
    frameCounter++;
    frameCounter = frameCounter % 2;
}

- (void) initializePattern
{
    // time = 0
    for(int x = 0; x < 9; x++)
    {
        for (int y = 0; y < 9; y++)
        {
            if (x == 0 || x == 8 || y == 0 || y == 8) {
                [currentPattern setColour:[NSColor redColor] AtLocationX:x LocationY:y Time:0];
            }
            else if (x == 1 || x == 7 || y == 1 || y ==7) {
                [currentPattern setColour:[NSColor orangeColor] AtLocationX:x LocationY:y Time:0];
            }
            else if (x == 2 || x == 6 || y == 2 || y == 6) {
                [currentPattern setColour:[NSColor yellowColor] AtLocationX:x LocationY:y Time:0];
            }
            else if (x == 3 || x == 5 || y == 3 || y ==5) {
                [currentPattern setColour:[NSColor purpleColor] AtLocationX:x LocationY:y Time:0];
            }
            else {
                [currentPattern setColour:[NSColor blueColor] AtLocationX:x LocationY:y Time:0];
            }
        }
    }
    
    // time = 1
    for(int x = 0; x < 9; x++)
    {
        for (int y = 0; y < 9; y++)
        {
            if (x == 0 || x == 8 || y == 0 || y == 8) {
                [currentPattern setColour:[NSColor blueColor] AtLocationX:x LocationY:y Time:1];
            }
            else if (x == 1 || x == 7 || y == 1 || y ==7) {
                [currentPattern setColour:[NSColor greenColor] AtLocationX:x LocationY:y Time:1];
            }
            else if (x == 2 || x == 6 || y == 2 || y == 6) {
                [currentPattern setColour:[NSColor purpleColor] AtLocationX:x LocationY:y Time:1];
            }
            else if (x == 3 || x == 5 || y == 3 || y ==5) {
                [currentPattern setColour:[NSColor orangeColor] AtLocationX:x LocationY:y Time:1];
            }
            else {
                [currentPattern setColour:[NSColor redColor] AtLocationX:x LocationY:y Time:1];
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
    NSAssert(success, @"ERROR CREATING PATTERN FILE");
}

@end

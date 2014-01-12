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
    timerFlag = false;
    
    simulatorView = [[ArrayView alloc] initWithCellWidth:80.0f CellHeight:80.0f HorizontalCells:4 VerticalCells:4];
    [self.window.contentView addSubview:simulatorView];
    testView = [[ColourView alloc] initWithFrame:NSMakeRect(0.0f, 380.0f, 90.0f, 90.0f)];
    [self.window.contentView addSubview:testView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
    
    NSLog(@"applicationDidFinishLaunching");
}

#pragma mark CONTROLLER METHODS

- (void) timerEventHandler {
    if (timerFlag) {
        [simulatorView setColour:[NSColor redColor] AtIndex:3];
        [testView setBackgroundColour:[NSColor redColor]];
    }
    else {
        [simulatorView setColour:[NSColor blueColor] AtIndex:3];
        [testView setBackgroundColour:[NSColor blueColor]];
    }
    timerFlag = !timerFlag;
    NSLog(@"timerEventHandler");
}
@end

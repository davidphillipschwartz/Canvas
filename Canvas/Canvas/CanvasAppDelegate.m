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
    
    simulatorView = [[ArrayView alloc] initWithX:125.0f Y:75.0f CellWidth:80.0f CellHeight:80.0f HorizontalCells:4 VerticalCells:4];
    [self.window.contentView addSubview:simulatorView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
}

#pragma mark CONTROLLER METHODS

- (void) timerEventHandler {
    if (timerFlag) {
        [simulatorView setColour:[NSColor redColor] AtIndex:3];
    }
    else {
        [simulatorView setColour:[NSColor blueColor] AtIndex:3];
    }
    timerFlag = !timerFlag;
}
@end

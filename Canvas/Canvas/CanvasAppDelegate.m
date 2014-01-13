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
    
    simulatorView = [[CanvasArrayView alloc] initWithX:0.0f Y:0.0f CellWidth:50.0f CellHeight:50.0f HorizontalCells:9 VerticalCells:9];
    [self.window.contentView addSubview:simulatorView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
}

#pragma mark CONTROLLER METHODS

- (void) timerEventHandler {
    int x = 3, y = 3;
    if (timerFlag) {
        [simulatorView setColour:[NSColor redColor] AtLocationX:x LocationY:y];
    }
    else {
        [simulatorView setColour:[NSColor blueColor] AtLocationX:x LocationY:y];
    }
    timerFlag = !timerFlag;
}
@end

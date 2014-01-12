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
    
    self.simulatorView = [[ArrayView alloc] initWithCellWidth:80.0f CellHeight:80.0f HorizontalCells:4 VerticalCells:4];
    self.testView = [[ColourView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 90.0f, 90.0f)];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
    
    NSLog(@"applicationDidFinishLaunching");
}

#pragma mark CONTROLLER METHODS

- (void) timerEventHandler {
    if (timerFlag) {
        [self.simulatorView setColour:[NSColor redColor] AtIndex:3];
    }
    else {
        [self.simulatorView setColour:[NSColor blueColor] AtIndex:3];
    }
    timerFlag = !timerFlag;
    NSLog(@"timerEventHandler");
}
@end

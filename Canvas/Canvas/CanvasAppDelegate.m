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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
}

#pragma mark CONTROLLER METHODS

- (void) timerEventHandler {
    if (timerFlag) {
        [self.simulatorView setBackgroundColor:[NSColor redColor]];
    }
    else {
        [self.simulatorView setBackgroundColor:[NSColor blueColor]];
    }
    timerFlag = !timerFlag;
}
@end

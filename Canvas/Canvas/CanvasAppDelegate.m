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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
}

#pragma mark CONTROLLER METHODS

- (void) timerEventHandler {
    
    for(int x = 0; x < 9; x++)
    {
        for (int y = 0; y < 9; y++)
        {
            if (x == 0 || x == 8 || y == 0 || y == 8) {
                [simulatorView setColour:[NSColor redColor] AtLocationX:x LocationY:y];
            }
            else if (x == 1 || x == 7 || y == 1 || y ==7) {
                [simulatorView setColour:[NSColor orangeColor] AtLocationX:x LocationY:y];
            }
            else if (x == 2 || x == 6 || y == 2 || y == 6) {
                [simulatorView setColour:[NSColor yellowColor] AtLocationX:x LocationY:y];
            }
            else if (x == 3 || x == 5 || y == 3 || y ==5) {
                [simulatorView setColour:[NSColor purpleColor] AtLocationX:x LocationY:y];
            }
            else {
                [simulatorView setColour:[NSColor blueColor] AtLocationX:x LocationY:y];
            }
        }
    }

}
@end

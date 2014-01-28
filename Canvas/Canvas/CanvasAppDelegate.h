//
//  CanvasAppDelegate.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-08.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CanvasArrayView.h"
#import "CanvasPattern.h"

@interface CanvasAppDelegate : NSObject <NSApplicationDelegate>
{
    CanvasArrayView *simulatorView;
    CanvasPattern *currentPattern;
    
    int frameCounter;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) NSTimer *timer;

@end

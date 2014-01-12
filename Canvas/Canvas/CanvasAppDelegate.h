//
//  CanvasAppDelegate.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-08.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ArrayView.h"

@interface CanvasAppDelegate : NSObject <NSApplicationDelegate> {
    BOOL timerFlag;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) IBOutlet ArrayView *simulatorView;
@property (nonatomic, strong) IBOutlet ColourView *testView;
@property (nonatomic, strong) NSTimer *timer;

@end

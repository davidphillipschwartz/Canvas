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
    CanvasPattern *currentPattern;
    int timestepCounter;
}

@property (weak) IBOutlet CanvasArrayView *simulatorView;
@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, weak) NSTimer *timer;

@property (weak) IBOutlet NSButton *playButton;

- (IBAction)tempoField:(id)sender;
- (IBAction)pauseButton:(id)sender;
- (IBAction)playButton:(id)sender;

@end

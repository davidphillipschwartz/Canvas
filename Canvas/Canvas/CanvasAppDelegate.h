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

@interface CanvasAppDelegate : NSObject <NSApplicationDelegate, CanvasArrayViewDelegate>
{
    CanvasPattern *currentPattern;
    NSInteger timestepCounter;
}

@property (weak) IBOutlet CanvasArrayView *simulatorView;
@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, weak) NSTimer *timer;

@property (weak) IBOutlet NSButton *playButton;

- (IBAction)tempoFieldAction:(id)sender;
- (IBAction)pauseButtonAction:(id)sender;
- (IBAction)playButtonAction:(id)sender;
- (IBAction)openPatternAction:(id)sender;

@end

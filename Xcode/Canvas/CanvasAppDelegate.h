//
//  CanvasAppDelegate.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-08.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// for serial comms
#include <IOKit/IOKitLib.h>
#include <IOKit/serial/IOSerialKeys.h>
#include <IOKit/IOBSD.h>
#include <IOKit/serial/ioss.h>
#include <sys/ioctl.h>

#import "CanvasArrayView.h"
#import "CanvasPattern.h"

@interface CanvasAppDelegate : NSObject <NSApplicationDelegate>
{
    int serialFileDescriptor;
}

@property (weak) IBOutlet CanvasArrayView *simulatorView;
@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, weak) NSTimer *timer;

@property (weak) IBOutlet NSButton *playButton;
@property (weak) IBOutlet NSSlider *frameSlider;

- (IBAction)tempoFieldAction:(id)sender;
- (IBAction)pauseButtonAction:(id)sender;
- (IBAction)playButtonAction:(id)sender;
- (IBAction)frameSliderAction:(id)sender;
- (IBAction)openPatternAction:(id)sender;
- (IBAction)savePatternAction:(id)sender;
- (IBAction)uploadPatternAction:(id)sender;

@end

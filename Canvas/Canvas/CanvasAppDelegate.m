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
    [self.simulatorView setHorizontalCells:5 VerticalCells:5];
    self.simulatorView.currentPattern = [[CanvasPattern alloc] initWithWidth:5 Height:5 Length:5];
    [self.simulatorView.currentPattern clearPatternToWhite];
    // note: frameSlider initialized in nib
    self.timer = nil;
}

#pragma mark CONTROLLER METHODS

- (void) timerEventHandler
{
    self.simulatorView.currentTime ++;
    self.simulatorView.currentTime %= self.simulatorView.currentPattern.length;
    [self.simulatorView drawFrame];
    [self.frameSlider setIntegerValue:self.simulatorView.currentTime];
}

- (IBAction)tempoFieldAction:(id)sender
{
    
}

- (IBAction)pauseButtonAction:(id)sender
{
    [self.timer invalidate];
    self.timer = nil;
    [self.frameSlider setIntegerValue:self.simulatorView.currentTime];
    [self.playButton setState:NSOffState];
}

- (IBAction)playButtonAction:(id)sender
{
    CGFloat interval = 1.0f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerEventHandler) userInfo:nil repeats:YES];
}

- (IBAction)frameSliderAction:(NSSlider*)sender
{
    if (self.timer != nil)
    {
        [self.timer invalidate];
        self.timer = nil;
        [self.playButton setState:NSOffState];
    }
    self.simulatorView.currentTime = self.frameSlider.integerValue;
    [self.simulatorView drawFrame];
}

- (IBAction)openPatternAction:(id)sender
{
    if (self.timer != nil)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    
    [openPanel beginWithCompletionHandler:^(NSInteger result)
    {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL *patternURL = [[openPanel URLs] objectAtIndex:0];
            NSData *patternData = [[NSFileManager defaultManager] contentsAtPath:[patternURL path]];
            CanvasPattern* newPattern = [[CanvasPattern alloc] initWithData:patternData];
            
            if (newPattern == nil)
            {
                // handle error
            }
            else
            {
                self.simulatorView.currentPattern = newPattern;
                [self.simulatorView setHorizontalCells:newPattern.width VerticalCells:newPattern.height];
                self.simulatorView.currentTime = 0;
                [self.simulatorView drawFrame];
                
                [self.frameSlider setIntegerValue:0];
                [self.frameSlider setNumberOfTickMarks:newPattern.length];
                [self.frameSlider setMaxValue:newPattern.length - 1];
            }
        }
    }];
}

- (IBAction)savePatternAction:(id)sender
{
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setAllowedFileTypes:[NSArray arrayWithObject:@"canvas"]];
    [savePanel setNameFieldStringValue:@"pattern"];
    
    [savePanel beginWithCompletionHandler:^(NSInteger result)
    {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL* url = [savePanel URL];
            NSString* path = [url path];
            [self.simulatorView.currentPattern savePatternToFileAtPath:path];
        }
    }];
}

@end

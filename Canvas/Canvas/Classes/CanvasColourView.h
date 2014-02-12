//
//  CanvasColourView.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-12.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol CanvasColourViewDelegate <NSObject>

- (void) updateColour:(NSColor*)arg_colour atX:(NSInteger)arg_x atY:(NSInteger)arg_y;

@end

@interface CanvasColourView : NSView <NSDraggingDestination>
{
    NSColor *colour;
    NSInteger _x, _y;
    id<CanvasColourViewDelegate> delegate;
}
- (id)initWithFrame:(NSRect)frameRect locationX:(NSInteger)arg_x locationY:(NSInteger)arg_y;
- (void)setBackgroundColour:(NSColor *)inputColour;
- (void)setDelegate:(id<CanvasColourViewDelegate>)arg_delegate;
- (void)drawRect;

@end

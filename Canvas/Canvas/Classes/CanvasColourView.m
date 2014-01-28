//
//  CanvasColourView.m
//  Canvas
//
//  Created by David Schwartz on 2014-01-12.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import "CanvasColourView.h"

@implementation CanvasColourView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        colour = [NSColor purpleColor]; // default = swag
    }
    return self;
}

- (void)setBackgroundColour:(NSColor *)inputColour {
    colour = inputColour;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor grayColor] set];
    NSRectFill([self bounds]);
    NSRect inset = NSInsetRect([self bounds], 1.0f, 1.0f);
    NSBezierPath *circlePath = [NSBezierPath bezierPathWithOvalInRect:inset];
    [colour set];
    [circlePath fill];
}

- (void)drawRect
{
    [self drawRect:[self bounds]];
}

@end

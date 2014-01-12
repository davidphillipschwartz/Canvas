//
//  ColourView.m
//  Canvas
//
//  Created by Malcolm Levy on 2014-01-12.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import "ColourView.h"

@implementation ColourView

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
	//[super drawRect:dirtyRect];
    [colour set];
    NSRectFill([self bounds]);
    NSLog(@"ColourView drawRect");
}

@end

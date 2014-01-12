//
//  ArrayView.m
//  Canvas
//
//  Created by David Schwartz on 2014-01-09.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import "ArrayView.h"

@implementation ArrayView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // default to a 2x2 grid
        
    }
    return self;
}

- (void) setBackgroundColor:(NSColor *)inputColor {
    color = inputColor;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
    
    [color set];
    NSRectFill([self bounds]);
}

@end

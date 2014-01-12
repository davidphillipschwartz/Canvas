//
//  ColourView.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-12.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ColourView : NSView
{
    NSColor *colour;
}

- (void)setBackgroundColour:(NSColor *)inputColour;

@end

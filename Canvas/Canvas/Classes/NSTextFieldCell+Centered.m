//
//  NSTextFieldCell+Centered.m
//  Canvas
//
//  Created by David Schwartz on 2014-02-11.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import "NSTextFieldCell+Centered.h"

@implementation NSTextFieldCell (Centered)

- (NSRect) titleRectForBounds:(NSRect)frame
{
    CGFloat stringHeight = self.attributedStringValue.size.height;
    NSRect titleRect = [super titleRectForBounds:frame];
    titleRect.origin.y = frame.origin.y + (frame.size.height - stringHeight) / 2.0;
    return titleRect;
}

- (void) drawInteriorWithFrame:(NSRect)cFrame inView:(NSView*)cView
{
    [super drawInteriorWithFrame:[self titleRectForBounds:cFrame] inView:cView];
}

@end

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
    self = [self initWithFrame:frame locationX:0 locationY:0];
    return self;
}

- (id)initWithFrame:(NSRect)frameRect locationX:(NSInteger)arg_x locationY:(NSInteger)arg_y
{
    self = [super initWithFrame:frameRect];
    if(self)
    {
        _x = arg_x;
        _y = arg_y;
        
        CGPoint bottomLeft = self.bounds.origin;
        CGPoint topLeft = CGPointMake(bottomLeft.x, bottomLeft.y + frameRect.size.height);
        CGPoint topRight = CGPointMake(topLeft.x + frameRect.size.width, topLeft.y);
        CGPoint bottomRight = CGPointMake(topRight.x, bottomLeft.y);
        CGPoint center = CGPointMake(bottomLeft.x + frameRect.size.width / 2, bottomLeft.y + frameRect.size.height / 2);
        
        CGPoint rightPointArray[3] = {bottomRight, topRight, center};
        CGPoint topPointArray[3] = {topRight, center, topLeft};
        CGPoint leftPointArray[3] = {topLeft, center, bottomRight};
        CGPoint bottomPointArray[3] = {bottomLeft, center, bottomRight};
        
        rightPath = [[NSBezierPath alloc] init];
        topPath = [[NSBezierPath alloc] init];
        leftPath = [[NSBezierPath alloc] init];
        bottomPath = [[NSBezierPath alloc] init];
        
        [rightPath appendBezierPathWithPoints:rightPointArray count:3];
        [topPath appendBezierPathWithPoints:topPointArray count:3];
        [leftPath appendBezierPathWithPoints:leftPointArray count:3];
        [bottomPath appendBezierPathWithPoints:bottomPointArray count:3];
        
        [rightPath closePath];
        [topPath closePath];
        [leftPath closePath];
        [bottomPath closePath];
        
        rightColour = topColour = leftColour = bottomColour = [NSColor whiteColor];
        [self registerForDraggedTypes:[NSArray arrayWithObject:NSColorPboardType]];
    }
    return self;
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSPasteboard* pboard = [sender draggingPasteboard];
    NSDragOperation sourceDragMask = [sender draggingSourceOperationMask];
    
    if ([[pboard types] containsObject:NSColorPboardType])
    {
        if (sourceDragMask & NSDragOperationGeneric)
        {
            return NSDragOperationGeneric;
        }
    }
    
    return NSDragOperationNone;
}

- (BOOL) performDragOperation:(id<NSDraggingInfo>)sender
{
    NSPasteboard* pboard = [sender draggingPasteboard];
    
    if ([[pboard types] containsObject:NSColorPboardType])
    {
        rightColour = topColour = leftColour = bottomColour = [NSColor colorFromPasteboard:pboard];
        [delegate updateColour:rightColour atX:_x atY:_y];
        [self setNeedsDisplay:YES];
    }
    
    return YES;
}

- (void) setDelegate:(id<CanvasColourViewDelegate>)arg_delegate
{
    delegate = arg_delegate;
}

- (void)setBackgroundColour:(NSColor *)inputColour {
    rightColour = topColour = leftColour = bottomColour = inputColour;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // draw border
    [rightColour set];
    NSRectFill([self bounds]);
    
    [[NSColor blackColor] set];
    NSBezierPath *border = [NSBezierPath bezierPathWithRect:[self bounds]];
    [border setLineWidth:1.0f];
    [border stroke];
    
    [rightPath stroke];
    [topPath stroke];
    [leftPath stroke];
    [bottomPath stroke];
    
    // draw interior of triangles

}

- (void)drawRect
{
    [self drawRect:[self bounds]];
}

@end

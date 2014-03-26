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

- (id)initWithFrame:(NSRect)frameRect locationX:(uint8_t)arg_x locationY:(uint8_t)arg_y
{
    self = [super initWithFrame:frameRect];
    if(self)
    {
        _x = arg_x;
        _y = arg_y;
        
        CGPoint bottomLeft = self.frame.origin;
        CGPoint topLeft = CGPointMake(bottomLeft.x, bottomLeft.y + frameRect.size.height);
        CGPoint topRight = CGPointMake(topLeft.x + frameRect.size.width, topLeft.y);
        CGPoint bottomRight = CGPointMake(topRight.x, bottomLeft.y);
        CGPoint center = CGPointMake(bottomLeft.x + frameRect.size.width / 2, bottomLeft.y + frameRect.size.height / 2);
        
        CGPoint rightPointArray[3] = {bottomRight, topRight, center};
        CGPoint topPointArray[3] = {topRight, center, topLeft};
        CGPoint leftPointArray[3] = {topLeft, center, bottomLeft};
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
        NSPoint originOfArrayView = self.superview.frame.origin;
        
        NSPoint locationInWindow = [sender draggingLocation];
        NSPoint locationInArrayView = NSMakePoint(locationInWindow.x - originOfArrayView.x, locationInWindow.y - originOfArrayView.y);

        if ([rightPath containsPoint:locationInArrayView])
        {
            rightColour = [NSColor colorFromPasteboard:pboard];
            [delegate updateColour:rightColour atX:_x atY:_y atQuadrant:CanvasColourViewQuadrantRight];
        }
        else if ([topPath containsPoint:locationInArrayView])
        {
            topColour = [NSColor colorFromPasteboard:pboard];
            [delegate updateColour:topColour atX:_x atY:_y atQuadrant:CanvasColourViewQuadrantTop];
        }
        else if ([leftPath containsPoint:locationInArrayView])
        {
            leftColour = [NSColor colorFromPasteboard:pboard];
            [delegate updateColour:leftColour atX:_x atY:_y atQuadrant:CanvasColourViewQuadrantLeft];
        }
        else if ([bottomPath containsPoint:locationInArrayView])
        {
            bottomColour = [NSColor colorFromPasteboard:pboard];
            [delegate updateColour:bottomColour atX:_x atY:_y atQuadrant:CanvasColourViewQuadrantBottom];
        }
        [self setNeedsDisplay:YES];
    }
    
    return YES;
}

- (void) setDelegate:(id<CanvasColourViewDelegate>)arg_delegate
{
    delegate = arg_delegate;
}

- (void)setBackgroundColour:(NSColor *)inputColour forQuadrant:(CanvasColourViewQuadrant)quadrant
{
    switch (quadrant)
    {
        case CanvasColourViewQuadrantRight:
            rightColour = inputColour;
            break;
        case CanvasColourViewQuadrantTop:
            topColour = inputColour;
            break;
        case CanvasColourViewQuadrantLeft:
            leftColour = inputColour;
            break;
        case CanvasColourViewQuadrantBottom:
            bottomColour = inputColour;
            break;
        default:
            [[NSException exceptionWithName:@"CanvasInvalidArgumentException" reason:@"Invalid Quadrant" userInfo:nil] raise];
            break;
    }
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // draw interior of triangles
    [rightColour set];
    [rightPath fill];
    
    [topColour set];
    [topPath fill];
    
    [leftColour set];
    [leftPath fill];
    
    [bottomColour set];
    [bottomPath fill];
    
    // draw border
    [[NSColor blackColor] set];
    NSBezierPath *border = [NSBezierPath bezierPathWithRect:[self bounds]];
    [border stroke];
    
    [rightPath stroke];
    [topPath stroke];
    [bottomPath stroke];
    [leftPath stroke];
}

- (void)drawRect
{
    [self drawRect:[self bounds]];
}

@end

//
//  CanvasColourView.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-12.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, CanvasColourViewQuadrant)
{
    CanvasColourViewQuadrantRight = 0,
    CanvasColourViewQuadrantTop = 1,
    CanvasColourViewQuadrantLeft = 2,
    CanvasColourViewQuadrantBottom = 3
};

@protocol CanvasColourViewDelegate <NSObject>

- (void)updateColour:(NSColor*)arg_colour atX:(NSInteger)arg_x atY:(NSInteger)arg_y atQuadrant:(CanvasColourViewQuadrant)arg_q;

@end

@interface CanvasColourView : NSView <NSDraggingDestination>
{
    NSColor *rightColour, *topColour, *leftColour, *bottomColour;
    NSBezierPath *rightPath, *topPath, *leftPath, *bottomPath;
    NSInteger _x, _y;
    id<CanvasColourViewDelegate> delegate;
}
- (id)initWithFrame:(NSRect)frameRect locationX:(NSInteger)arg_x locationY:(NSInteger)arg_y;
- (void)setBackgroundColour:(NSColor *)inputColour forQuadrant:(CanvasColourViewQuadrant)quadrant;
- (void)setDelegate:(id<CanvasColourViewDelegate>)arg_delegate;
- (void)drawRect;

@end

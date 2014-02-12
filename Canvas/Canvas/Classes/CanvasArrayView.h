//
//  CanvasArrayView.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-09.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CanvasColourView.h"

@protocol CanvasArrayViewDelegate <NSObject>

- (void) updatePatternWithColour:(NSColor*)arg_colour atLocationX:(NSInteger)arg_x locationY:(NSInteger)arg_y;

@end

@interface CanvasArrayView : NSView <CanvasColourViewDelegate>
{
    NSMutableArray *cellArray;
    id<CanvasArrayViewDelegate> delegate;
}

@property(nonatomic, readonly) NSInteger numberOfColumns;
@property(nonatomic, readonly) NSInteger numberOfRows;

- (void)setHorizontalCells:(NSInteger)horizontalCells VerticalCells:(NSInteger)verticalCells;
- (void)setColour:(NSColor *)inputColour AtLocationX:(int)x LocationY:(int)y;
- (void)setDelegate:(id<CanvasArrayViewDelegate>)arg_delegate;

@end

//
//  CanvasArrayView.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-09.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CanvasColourView.h"

@interface CanvasArrayView : NSView
{
    NSMutableArray *cellArray;
}

@property(nonatomic, readwrite) NSInteger numberOfColumns;
@property(nonatomic, readwrite) NSInteger numberOfRows;

- (id)initWithX:(CGFloat)_x Y:(CGFloat)_y CellWidth:(CGFloat)cellWidth CellHeight:(CGFloat)cellHeight HorizontalCells:(int)horizontalCells VerticalCells:(int)verticalCells;
- (void)setColour:(NSColor *)inputColour AtLocationX:(int)x LocationY:(int)y;

@end

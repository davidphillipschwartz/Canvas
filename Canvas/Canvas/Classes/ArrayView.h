//
//  ArrayView.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-09.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ColourView.h"

@interface ArrayView : NSView
{
    NSMutableArray *cellArray;
}

- (id)initWithCellWidth:(CGFloat)cellWidth CellHeight:(CGFloat)cellHeight HorizontalCells:(int)horizontalCells VerticalCells:(int)verticalCells;

- (void)setColour:(NSColor *)inputColour AtIndex:(int)index;

@end

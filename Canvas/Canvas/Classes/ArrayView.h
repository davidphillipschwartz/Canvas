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
    int arrayWidth;
    int arrayHeight;
}

- (id)initWithX:(CGFloat)_x Y:(CGFloat)_y CellWidth:(CGFloat)cellWidth CellHeight:(CGFloat)cellHeight HorizontalCells:(int)horizontalCells VerticalCells:(int)verticalCells;

- (void)setColour:(NSColor *)inputColour AtLocationX:(int)x LocationY:(int)y;

@end

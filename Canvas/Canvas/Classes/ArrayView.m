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
        // default to a 1x1 grid
        // incomplete
    }
    return self;
}

- (id)initWithX:(CGFloat)_x Y:(CGFloat)_y CellWidth:(CGFloat)cellWidth CellHeight:(CGFloat)cellHeight HorizontalCells:(int)horizontalCells VerticalCells:(int)verticalCells
{
    
    NSRect frame = NSMakeRect(_x, _y, cellWidth*horizontalCells, cellHeight*verticalCells);
    self = [super initWithFrame:frame];
    if (self) {
        cellArray = [[NSMutableArray alloc] init];
        for (int y = 0; y < verticalCells; y++)
        {
            for (int x = 0; x < horizontalCells; x++)
            {
                NSRect cellFrame = NSMakeRect(x * cellWidth, y * cellHeight, cellWidth, cellHeight);
                ColourView *cell = [[ColourView alloc] initWithFrame:cellFrame];
                [self addSubview:cell];
                [cellArray addObject:cell];
            }
        }
    }
    return self;
}

- (void)setColour:(NSColor *)inputColour AtIndex:(int)index
{
    ColourView *cell = cellArray[index];
    [cell setBackgroundColour:inputColour];
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
	//[super drawRect:dirtyRect];
    for (int i = 0; i < [cellArray count]; i++)
    {
        NSRect fml = ((ColourView *)cellArray[i]).bounds;
        [cellArray[i] drawRect:fml];
    }
}

@end

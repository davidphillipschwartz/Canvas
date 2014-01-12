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
    // default to 2x2 grid filling frame
    self = [self initWithX:frame.origin.x Y:frame.origin.y CellWidth:(frame.size.width / 2) CellHeight:(frame.size.height / 2) HorizontalCells:2 VerticalCells:2];
    
    return self;
}

- (id)initWithX:(CGFloat)_x Y:(CGFloat)_y CellWidth:(CGFloat)cellWidth CellHeight:(CGFloat)cellHeight HorizontalCells:(int)horizontalCells VerticalCells:(int)verticalCells
{
    NSRect frame = NSMakeRect(_x, _y, cellWidth*horizontalCells, cellHeight*verticalCells);
    self = [super initWithFrame:frame];
    if (self) {
        cellArray = [[NSMutableArray alloc] init];
        arrayWidth = horizontalCells;
        arrayHeight = verticalCells;
        for (int y = 0; y < arrayHeight; y++)
        {
            for (int x = 0; x < arrayWidth; x++)
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

- (void)setColour:(NSColor *)inputColour AtLocationX:(int)x LocationY:(int)y
{
    if (x >= arrayWidth || y >= arrayHeight)
    {
        NSLog(@"ArrayView setColour: index out of bounds");
    }
    else
    {
        int index = y * arrayWidth + x;
        ColourView *cell = cellArray[index];
        [cell setBackgroundColour:inputColour];
        [self setNeedsDisplay:YES];
    }
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

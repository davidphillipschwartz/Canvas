//
//  CanvasArrayView.m
//  Canvas
//
//  Created by David Schwartz on 2014-01-09.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import "CanvasArrayView.h"

@implementation CanvasArrayView
@synthesize numberOfColumns = _numberOfColumns, numberOfRows = _numberOfRows;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        cellArray = nil;
        _numberOfRows = 0;
        _numberOfColumns = 0;
    }
    return self;
}

- (void)setHorizontalCells:(NSInteger)horizontalCells VerticalCells:(NSInteger)verticalCells
{
    _numberOfColumns = horizontalCells;
    _numberOfRows = verticalCells;
    CGFloat cellWidth = self.frame.size.width / self.numberOfColumns;
    CGFloat cellHeight = self.frame.size.height / self.numberOfRows;
    cellArray = [[NSMutableArray alloc] init];
    for (int y = 0; y < self.numberOfRows; y++)
    {
        for (int x = 0; x < self.numberOfColumns; x++)
        {
            NSRect cellFrame = NSMakeRect(x * cellWidth, y * cellHeight, cellWidth, cellHeight);
            CanvasColourView *cell = [[CanvasColourView alloc] initWithFrame:cellFrame];
            [self addSubview:cell];
            [cellArray addObject:cell];
        }
    }
}

- (void)setColour:(NSColor *)inputColour AtLocationX:(int)x LocationY:(int)y
{
    if (x >= self.numberOfColumns || y >= self.numberOfRows)
    {
        NSLog(@"ArrayView setColour: index out of bounds");
    }
    else
    {
        long index = y * self.numberOfColumns + x;
        CanvasColourView *cell = cellArray[index];
        [cell setBackgroundColour:inputColour];
        [self setNeedsDisplay:YES];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    for (int i = 0; i < [cellArray count]; i++)
    {
        [cellArray[i] drawRect];
    }
}

@end

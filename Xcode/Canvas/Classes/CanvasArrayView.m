//
//  CanvasArrayView.m
//  Canvas
//
//  Created by David Schwartz on 2014-01-09.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import "CanvasArrayView.h"

@implementation CanvasArrayView
@synthesize currentTime;
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

// canvasColourView delegate method
- (void)updateColour:(NSColor *)arg_colour atX:(NSInteger)arg_x atY:(NSInteger)arg_y atQuadrant:(CanvasColourViewQuadrant)arg_q
{
    if (self.currentPattern != nil)
    {
        [self.currentPattern setColour:arg_colour AtLocationX:arg_x LocationY:arg_y Quadrant:arg_q Time:self.currentTime];
    }
}

- (void)setHorizontalCells:(NSInteger)horizontalCells VerticalCells:(NSInteger)verticalCells
{
    _numberOfColumns = horizontalCells;
    _numberOfRows = verticalCells;
    CGFloat cellWidth = self.frame.size.width / self.numberOfColumns;
    CGFloat cellHeight = self.frame.size.height / self.numberOfRows;
    cellArray = [[NSMutableArray alloc] init];
    for (NSInteger y = 0; y < self.numberOfRows; y++)
    {
        for (NSInteger x = 0; x < self.numberOfColumns; x++)
        {
            NSRect cellFrame = NSMakeRect(x * cellWidth, y * cellHeight, cellWidth, cellHeight);
            CanvasColourView *cell = [[CanvasColourView alloc] initWithFrame:cellFrame locationX:x locationY:y];
            [cell setDelegate:self];
            [self addSubview:cell];
            [cellArray addObject:cell];
        }
    }
}

- (void)setColour:(NSColor *)inputColour AtLocationX:(NSInteger)x LocationY:(NSInteger)y Quadrant:(CanvasColourViewQuadrant)quadrant
{
    if (x >= self.numberOfColumns || y >= self.numberOfRows)
    {
        NSLog(@"ArrayView setColour: index out of bounds");
    }
    else
    {
        NSInteger index = y * self.numberOfColumns + x;
        CanvasColourView *cell = cellArray[index];
        [cell setBackgroundColour:inputColour forQuadrant:quadrant];
        [self setNeedsDisplay:YES];
    }
}

- (void)drawFrame
{
    for(NSInteger x = 0; x < self.currentPattern.width; x++)
    {
        for (NSInteger y = 0; y < self.currentPattern.height; y++)
        {
            for (NSInteger q = 0; q < 4; q++)
            {
                NSColor *pixelColour = [self.currentPattern getColourAtLocationX:x LocationY:y Quadrant:q Time:self.currentTime];
                [self setColour:pixelColour AtLocationX:x LocationY:y Quadrant:q];
            }
        }
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

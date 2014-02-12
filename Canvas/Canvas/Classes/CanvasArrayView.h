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

@property(nonatomic, readonly) NSInteger numberOfColumns;
@property(nonatomic, readonly) NSInteger numberOfRows;

- (void)setHorizontalCells:(NSInteger)horizontalCells VerticalCells:(NSInteger)verticalCells;
- (void)setColour:(NSColor *)inputColour AtLocationX:(int)x LocationY:(int)y;

@end

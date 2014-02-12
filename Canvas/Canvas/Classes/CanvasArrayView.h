//
//  CanvasArrayView.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-09.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CanvasColourView.h"
#import "CanvasPattern.h"

@interface CanvasArrayView : NSView <CanvasColourViewDelegate>
{
    NSMutableArray *cellArray;
}

@property(nonatomic, readonly) NSInteger numberOfColumns;
@property(nonatomic, readonly) NSInteger numberOfRows;
@property(nonatomic, readwrite) NSInteger currentTime;
@property(nonatomic, readwrite) CanvasPattern* currentPattern;

- (void)setHorizontalCells:(NSInteger)horizontalCells VerticalCells:(NSInteger)verticalCells;
- (void)setColour:(NSColor *)inputColour AtLocationX:(NSInteger)x LocationY:(NSInteger)y;
- (void)drawFrame;

@end

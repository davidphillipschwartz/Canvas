//
//  ArrayView.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-09.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ArrayView : NSView {
    NSColor *color;
    
}

- (id) initWithCellWidth:(CGFloat)cellWidth CellHeight:(CGFloat)cellHeight HorizontalCells:(int)horizontalCells VerticalCells:(int)verticalCells;
- (void) setBackgroundColor:(NSColor *) inputColor;

@end

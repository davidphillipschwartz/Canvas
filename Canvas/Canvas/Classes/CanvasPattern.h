//
//  CanvasPattern.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-12.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CanvasArrayView.h"

// incomplete

typedef struct
{
    float r, g, b;
} CanvasPixel;

@interface CanvasPattern : NSObject
{
    int width, height, length;
    CanvasPixel* pixelArray;
}

- (id)initWithWidth:(int)_width Height:(int)_height Length:(int)_length;
- (void)setColour:(NSColor*)colour AtLocationX:(int)x LocationY:(int)y Time:(int)t;

@end
//
//  CanvasPattern.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-12.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CanvasColourView.h"

typedef struct
{
    uint8_t r, g, b;
} CanvasPixel;

@interface CanvasPattern : NSObject
{
    CanvasPixel* pixelArray;
}

@property (nonatomic, readonly) uint8_t width;
@property (nonatomic, readonly) uint8_t height;
@property (nonatomic, readonly) uint8_t length;

- (id)initWithWidth:(uint8_t)_width Height:(uint8_t)_height Length:(uint8_t)_length;
- (id)initWithData:(NSData*)_data;
- (void)setColour:(NSColor*)colour AtLocationX:(uint8_t)x LocationY:(uint8_t)y Quadrant:(CanvasColourViewQuadrant)quadrant Time:(uint8_t)t;
- (void)initializeWithDefaultPattern;
- (void)clearPatternToWhite;
- (NSColor*)getColourAtLocationX:(uint8_t)x LocationY:(uint8_t)y Quadrant:(CanvasColourViewQuadrant)quadrant Time:(uint8_t)t;
- (NSData*)convertPatternToData;
- (BOOL)savePatternToFileAtPath:(NSString*)arg_path;

@end

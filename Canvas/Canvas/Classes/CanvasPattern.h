//
//  CanvasPattern.h
//  Canvas
//
//  Created by David Schwartz on 2014-01-12.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct
{
    double r, g, b;
} CanvasPixel;

@interface CanvasPattern : NSObject
{
    CanvasPixel* pixelArray;
}

@property (nonatomic, readonly) NSInteger width;
@property (nonatomic, readonly) NSInteger height;
@property (nonatomic, readonly) NSInteger length;

- (id)initWithWidth:(NSInteger)_width Height:(NSInteger)_height Length:(NSInteger)_length;
- (id)initWithData:(NSData*)_data;
- (void)setColour:(NSColor*)colour AtLocationX:(NSInteger)x LocationY:(NSInteger)y Time:(NSInteger)t;
- (void)initializeWithDefaultPattern;
- (void)clearPatternToWhite;
- (NSColor*)getColourAtLocationX:(NSInteger)x LocationY:(NSInteger)y Time:(NSInteger)t;
- (NSData*)convertPatternToData;
- (BOOL)savePatternToFileAtPath:(NSString*)arg_path;

@end

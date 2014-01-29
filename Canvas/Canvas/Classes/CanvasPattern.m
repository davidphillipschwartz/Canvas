//
//  CanvasPattern.m
//  Canvas
//
//  Created by David Schwartz on 2014-01-12.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import "CanvasPattern.h"

@implementation CanvasPattern

- (id)init
{
    self = [self initWithWidth:0 Height:0 Length:0];
    return self;
}

- (id)initWithWidth:(int)_width Height:(int)_height Length:(int)_length
{
    self = [super init];
    if (self) {
        width = _width;
        height = _height;
        length = _length;
        pixelArray = calloc(width*height*length, sizeof(CanvasPixel)); // set all black
    }
    return self;
}

-(void)setColour:(NSColor *)colour AtLocationX:(int)x LocationY:(int)y Time:(int)t
{
    if ((x >= width) || (y >= height) || (t >= length))
    {
        NSLog(@"CanvasPattern setColour: location out of bounds");
    }
    else
    {
        // get components of input colour
        double red, green, blue;
        [colour getRed:&red green:&green blue:&blue alpha:NULL];
        
        // store new pixel
        CanvasPixel newPixel = { .r = red, .g = green, .b = blue };
        int index = width * height * t + width * y + x;
        pixelArray[index] = newPixel;
    }
}

- (NSColor*)getColourAtLocationX:(int)x LocationY:(int)y Time:(int)t
{
    if ((x >= width) || (y >= height) || (t >= length))
    {
        NSLog(@"CanvasPattern getColour: location out of bounds");
        return nil;
    }
    else
    {
        int index = width * height * t + width * y + x;
        CanvasPixel pixel = pixelArray[index];
        return [NSColor colorWithCalibratedRed:pixel.r green:pixel.g blue:pixel.b alpha:1.0f];
    }
}

-(NSData*)convertPatternToData
{
    NSData *patternData = [[NSData alloc] initWithBytes:pixelArray length:length * width * height * sizeof(CanvasPixel)];
    return patternData;
}

- (void)dealloc
{
    free(pixelArray);
}

@end

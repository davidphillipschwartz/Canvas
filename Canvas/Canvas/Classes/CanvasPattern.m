//
//  CanvasPattern.m
//  Canvas
//
//  Created by David Schwartz on 2014-01-12.
//  Copyright (c) 2014 Hybridity. All rights reserved.
//

#import "CanvasPattern.h"

@implementation CanvasPattern

@synthesize width = _width, height = _height, length = _length;

- (id)init
{
    self = [self initWithWidth:0 Height:0 Length:0];
    return self;
}

- (id)initWithWidth:(NSInteger)arg_width Height:(NSInteger)arg_height Length:(NSInteger)arg_length
{
    self = [super init];
    if (self) {
        _width = arg_width;
        _height = arg_height;
        _length = arg_length;
        pixelArray = calloc(_width*_height*_length, sizeof(CanvasPixel)); // set all black
    }
    return self;
}

- (id)initWithData:(NSData *)_data
{
    NSAssert(_data != nil, @"DATA IS NIL AGHHHH");
    
    NSInteger* prefixBuffer = malloc(3 * sizeof(NSInteger));
    [_data getBytes:prefixBuffer length:3 * sizeof(NSInteger)];
    self = [self initWithWidth:prefixBuffer[0] Height:prefixBuffer[1] Length:prefixBuffer[2]];
    free(prefixBuffer);
    
    NSRange pixelDataRange = {.location = 3 * sizeof(NSInteger), .length = _width * _height * _length * sizeof(CanvasPixel)};
    double* buffer = malloc(_width * _height * _length * sizeof(CanvasPixel));
    [_data getBytes:buffer range:pixelDataRange];
    
    for (int t = 0; t < _length; t++)
    {
        for(int y = 0; y < _height; y++)
        {
            for (int x = 0; x < _width; x++)
            {
                NSInteger currentRedIndex = 3 * (_width * _height * t + _width * y + x);
                NSInteger currentGreenIndex = currentRedIndex + 1;
                NSInteger currentBlueIndex = currentGreenIndex + 1;
                
                NSColor* currentColour = [NSColor colorWithCalibratedRed:buffer[currentRedIndex] green:buffer[currentGreenIndex] blue:buffer[currentBlueIndex] alpha:1.0f];
                
                [self setColour:currentColour AtLocationX:x LocationY:y Time:t];
            }
        }
    }
    free(buffer);
    
    return self;
}

- (void) initializeWithDefaultPattern
{
    BOOL assertionCondition = (_width == 9) && (_height == 9) && (_length == 5);
    NSAssert(assertionCondition, @"ERROR: default pattern dimensions are 9x9x5");
    
    NSColor* colourArray[5];
    colourArray[0] = [NSColor purpleColor];
    colourArray[1] = [NSColor blueColor];
    colourArray[2] = [NSColor purpleColor];
    colourArray[3] = [NSColor blueColor];
    colourArray[4] = [NSColor redColor];
    
    // time = 0
    for (int t = 0; t < 5; t++)
    {
        for(int x = 0; x < 9; x++)
        {
            for (int y = 0; y < 9; y++)
            {
                if (x == 0 || x == 8 || y == 0 || y == 8) {
                    [self setColour:colourArray[t] AtLocationX:x LocationY:y Time:t];
                }
                else if (x == 1 || x == 7 || y == 1 || y ==7) {
                    [self setColour:colourArray[(t+1)%5] AtLocationX:x LocationY:y Time:t];
                }
                else if (x == 2 || x == 6 || y == 2 || y == 6) {
                    [self setColour:colourArray[(t+2)%5] AtLocationX:x LocationY:y Time:t];
                }
                else if (x == 3 || x == 5 || y == 3 || y == 5) {
                    [self setColour:colourArray[(t+3)%5] AtLocationX:x LocationY:y Time:t];
                }
                else {
                    [self setColour:colourArray[(t+4)%5] AtLocationX:x LocationY:y Time:t];
                }
            }
        }
    }
}

-(NSData*)convertPatternToData
{
    void* buffer = malloc(3 * sizeof(NSInteger) + _width * _height * _length * sizeof(CanvasPixel));
    NSInteger prefix [3] = {_width, _height, _length};
    memcpy(buffer, prefix, 3 * sizeof(NSInteger));
    memcpy(buffer + 3 * sizeof(NSInteger), pixelArray, _width * _height * _length * sizeof(CanvasPixel));
    
    NSData* patternData = [[NSData alloc] initWithBytes:buffer
                                                 length:3 * sizeof(NSInteger) + _width * _height * _length * sizeof(CanvasPixel)];
    free(buffer);
    return patternData;
}

-(void)setColour:(NSColor *)colour AtLocationX:(NSInteger)x LocationY:(NSInteger)y Time:(NSInteger)t
{
    if ((x >= _width) || (y >= _height) || (t >= _length))
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
        NSInteger index = _width * _height * t + _width * y + x;
        pixelArray[index] = newPixel;
    }
}

- (NSColor*)getColourAtLocationX:(NSInteger)x LocationY:(NSInteger)y Time:(NSInteger)t
{
    if ((x >= _width) || (y >= _height) || (t >= _length))
    {
        NSLog(@"CanvasPattern getColour: location out of bounds");
        return nil;
    }
    else
    {
        NSInteger index = _width * _height * t + _width * y + x;
        CanvasPixel pixel = pixelArray[index];
        return [NSColor colorWithCalibratedRed:pixel.r green:pixel.g blue:pixel.b alpha:1.0f];
    }
}

- (void)dealloc
{
    free(pixelArray);
}

@end

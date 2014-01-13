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
    // incomplete
    return nil;
}

- (id)initWithWidth:(int)_width Height:(int)_height Length:(int)_length
{
    self = [super init];
    if (self) {
        width = _width;
        height = _height;
        length = _length;
        pixelArray = malloc(width*height*length*sizeof(CanvasPixel));
    }
    return self;
}

- (void)dealloc
{
    free(pixelArray);
}

@end

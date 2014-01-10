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

- (void) setBackgroundColor:(NSColor *) inputColor;

@end

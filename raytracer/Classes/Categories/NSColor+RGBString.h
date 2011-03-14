//
//  NSColor+RGBString.h
//  raytracer
//
//  http://www.cocoabuilder.com/archive/cocoa/133826-nscolor-question.html
//
//  Created by Kurt Aadnøy on 13.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface NSColor (RGBString)
    +(NSColor*)colorWithRGBString:(NSString*)string;
    +(NSColor*)colorWithRGBAString:(NSString*)string;
@end

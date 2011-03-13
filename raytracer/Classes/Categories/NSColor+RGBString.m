//
//  NSColor+RGBString.m
//  raytracer
//
//  Created by Kurt Aadnøy on 13.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import "NSColor+RGBString.h"


@implementation NSColor (RGBString)

// TODO: Better error handling for invalid string formats
+(NSColor*)colorWithRGBString:(NSString*)string {
    NSArray *channels = [string componentsSeparatedByString:@","];
    NSColor *color = [NSColor colorWithDeviceRed:
                      [[channels objectAtIndex:0] floatValue] / 255.0
                                           green:[[channels objectAtIndex:1] floatValue] / 255.0
                                            blue:[[channels objectAtIndex:2] floatValue] / 255.0
                                           alpha:1.0];
    return color;
}

+(NSColor*)colorWithRGBAString:(NSString*)string {
    NSArray *channels = [string componentsSeparatedByString:@","];
    NSColor *color = [NSColor colorWithDeviceRed:
                      [[channels objectAtIndex:0] floatValue] / 255.0
                                           green:[[channels objectAtIndex:1] floatValue] / 255.0
                                            blue:[[channels objectAtIndex:2] floatValue] / 255.0
                                           alpha:[[channels objectAtIndex:3] floatValue] / 255.0];
    return color;
}

@end

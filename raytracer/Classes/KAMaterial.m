//
//  KAMaterial.m
//  raytracer
//
//  Created by Kurt Aadnøy on 19.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "KAMaterial.h"
#import "NSColor+RGBString.h"

@implementation KAMaterial

@synthesize color;
@synthesize reflection;

-(id)initWithRGBString:(NSString*)rgbString
         andReflection:(float)aReflection {
    if(![super init]) return nil;
    
    self.color = [[NSColor colorWithRGBString:rgbString] retain];
    self.reflection = aReflection;
    
    return self;
}

- (void)dealloc {
    [color release];
    [super dealloc];
}

@end

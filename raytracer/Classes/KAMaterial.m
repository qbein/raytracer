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
@synthesize reflection, specular, specularPower;

-(id)initWithRGBString:(NSString*)rgbString
            reflection:(float)aReflection
              specular:(float)aSpecular
      andSpecularPower:(float)aPower {
    if(![super init]) return nil;
    
    self.color = [[NSColor colorWithRGBString:rgbString] retain];
    self.reflection = aReflection;
    self.specular = aSpecular;
    self.specularPower = aPower;
    
    return self;
}

- (void)dealloc {
    [color release];
    [super dealloc];
}

@end

//
//  KAMaterial.h
//  raytracer
//
//  Created by Kurt Aadnøy on 19.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface KAMaterial : NSObject

@property (retain) NSColor* color;
@property float reflection, specular, specularPower;

-(id)initWithRGBString:(NSString*)rgbString
            reflection:(float)aReflection
              specular:(float)aSpecular
      andSpecularPower:(float)aPower;

@end

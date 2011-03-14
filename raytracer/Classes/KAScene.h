//
//  Scene.h
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vendor/JSON/JSON.h"
#import "Categories/NSColor+RGBString.h"
#import "Geometry/KASphere.h"
#import "KALight.h"

@interface KAScene : NSObject

@property (retain) NSMutableArray* lights;
@property (retain) NSMutableArray* primitives;

-(id)initFromFile:(NSString*)filename;

@end
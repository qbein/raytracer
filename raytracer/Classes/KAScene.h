//
//  Scene.h
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "Vendor/JSON/JSON.h"
#import "Categories/NSColor+RGBString.h"

#define VERSION "1.0-alpha"

@interface KAScene : NSObject

@property (retain) NSMutableArray* lights;
@property (retain) NSMutableArray* primitives;
@property (retain) NSMutableDictionary* materials;
@property int width;
@property int height;
@property float scale;
@property (retain) NSString* version;

-(id)initFromFile:(NSString*)filename;

@end

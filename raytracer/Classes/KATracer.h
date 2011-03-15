//
//  Tracer.h
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import <AppKit/AppKit.h>

@class KAScene;

#define RAY_STARTING_POINT -1000
#define RAY_MAX_LENGTH 99999

@interface KATracer : NSObject

@property (retain) NSString* filename;

-(id)initWithOutputFile:(NSString*)aFilename;

-(void)renderScene:(KAScene*)scene;

@end


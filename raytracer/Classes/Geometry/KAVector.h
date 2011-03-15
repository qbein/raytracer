//
//  Vector.h
//  raytracer
//
//  Created by Kurt Aadnøy on 14.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KAPoint;

@interface KAVector : NSObject

@property float x;
@property float y;
@property float z;

-(id)initWithX:(float)anX y:(float)aY andZ:(float)aZ;

+(id)vectorFromPoint:(KAPoint*)aPoint;

+(id)vectorFromPoint:(KAPoint*)pointA substractedBy:(KAPoint*)pointB;

+(id)vectorFromPoint:(KAPoint*)pointA addedBy:(KAPoint*)pointB;

-(KAVector*)add:(KAVector*)aVector;

-(KAVector*)multiplyWith:(KAVector*)aVector;

-(KAVector*)multiplyWithFloat:(float)aFloat;

-(float)summarize;

@end

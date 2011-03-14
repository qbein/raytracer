//
//  Vector.h
//  raytracer
//
//  Created by Kurt Aadnøy on 14.03.11.
//  Copyright 2011 aadnoy.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KAVector : NSObject

@property float x;
@property float y;
@property float z;

- (id)initWithX:(float)anX y:(float)aY andZ:(float)aZ;

-(void)addVector:(KAVector*)vector;

@end

#import <GHUnit/GHUnit.h>

#import "KAPoint3d.h"
#import "KARay.h"

@interface KARayTest : GHTestCase { }
@end

@implementation KARayTest

- (void)testRayBounce {
    // http://www.cs.unc.edu/~rademach/xroads-RT/RTarticle.html
    KARay* ray = [[KARay alloc] initWithOrigin:[KAPoint3d pointWithX:2 y:0 andZ:0]
                                  andDirection:[KAVector3d vectorWithX:0 y:0 andZ:1]];
    
    KARay* bounce = [ray rayBouncedOfSphereAt:[KAPoint3d pointWithX:2 y:0 andZ:3]
                            usingNormalVector:[KAVector3d vectorWithX:1 y:0 andZ:1]];

    KAVector3d* reflectionVector = [KAVector3d vectorWithX:-2 y:0 andZ:-1];
    
    GHAssertEquals(reflectionVector.x, bounce.direction.x, nil);
    GHAssertEquals(reflectionVector.y, bounce.direction.y, nil);
    GHAssertEquals(reflectionVector.z, bounce.direction.z, nil);
}

@end
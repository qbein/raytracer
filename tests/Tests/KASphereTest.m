#import <GHUnit/GHUnit.h>

#import "KASphere.h"
#import "KAPoint3d.h"
#import "KAMaterial.h"
#import "KARay.h"
#import "NSColor+RGBString.h"

#define RAY_MAX_LENGTH 9999.0f

@interface KASphereTest : GHTestCase { }
@end

@implementation KASphereTest

- (void)testSphereIntersection {
    float radius = 10.0f;
    
    // Setup sphere and ray
    KAMaterial* m = [[KAMaterial alloc] initWithRGBString:@"255,0,0" andReflection:1];
    KAPoint3d* spherePoint = [KAPoint3d pointWithX:50 y:50 andZ:100];
    KASphere* sphere = [[KASphere alloc] initWithPosition:spherePoint radius:radius andMaterial:m];
    KAPoint3d* rayOrigin = [KAPoint3d pointWithX:0 y:50 andZ:0];
    KAVector3d* rayDirection = [KAVector3d vectorFromPoint:[KAPoint3d pointWithX:0 y:0 andZ:1]];
    KARay* ray = [[KARay alloc] initWithOrigin:rayOrigin andDirection:rayDirection];
    
    // We test intersection for a circle just inside and outside of the sphere
    for(int deg=0; deg<360; deg++) {
        float theta = deg * (pi / 180);
        
        // First we put the point 0.1f outside the sphere - all should miss
        ray.origin.x = 50 + sin(theta) * (radius + 0.1f);
        ray.origin.y = 50 + cos(theta) * (radius + 0.1f);
                
        GHAssertEquals([sphere findIntersectionForRay:ray withMaxDepth:RAY_MAX_LENGTH],
                       RAY_MAX_LENGTH,
                       @"Ray %@ should miss sphere %@ (%i degrees)", ray, sphere, deg);
        
        // Now we put it exactly on the sphere edge - all should hit
        ray.origin.x = 50 + sin(theta) * radius;
        ray.origin.y = 50 + cos(theta) * radius;
        
        GHAssertLessThanOrEqual([sphere findIntersectionForRay:ray withMaxDepth:RAY_MAX_LENGTH],
                       100.0f,
                       @"Ray %@ should miss sphere %@ (%i degrees)", ray, sphere, deg);
    }
    
    // Test a direct hit, see check that distance is sphere center point - radius
    ray.origin.y = ray.origin.x = 50;
    GHAssertEquals([sphere findIntersectionForRay:ray withMaxDepth:RAY_MAX_LENGTH], 90.0f, @"Distance should be 90.0f at center of sphere");
}

@end
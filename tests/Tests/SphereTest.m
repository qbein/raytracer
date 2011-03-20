#import <GHUnit/GHUnit.h>

#import "KASphere.h"
#import "KAPoint3d.h"
#import "KAMaterial.h"
#import "KARay.h"
#import "NSColor+RGBString.h"

@interface SphereTest : GHTestCase { }
@end

@implementation SphereTest

- (BOOL)shouldRunOnMainThread {
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES
    return NO;
}

- (void)setUpClass {
    // Run at start of all tests in the class
}

- (void)tearDownClass {
    // Run at end of all tests in the class
}

- (void)setUp {
    // Run before each test method
}

- (void)tearDown {
    // Run after each test method
}  

- (void)testSphereIntersection {
    KAMaterial* m = [[KAMaterial alloc] initWithRGBString:@"255,0,0" andReflection:0.5];
    KASphere* sphere = [[KASphere alloc] initWithPosition:[KAPoint3d pointWithX:50 y:50 andZ:0]
                                                   radius:10
                                              andMaterial:m];
    
    KARay* missingRay = [[KARay alloc] initWithOrigin:[KAPoint3d pointWithX:39 y:50 andZ:0] andDirection:[KAVector3d vectorFromPoint:[KAPoint3d pointWithX:0 y:0 andZ:1]]];
    
    NSLog(@"%@", missingRay.origin);
    GHAssertEquals(1000.0f, [sphere findIntersectionsForRay:missingRay withMaxDepth:1000.0f], @"Ray should not intersect sphere %@", missingRay.origin);
    
    missingRay.origin.x = 50;
    NSLog(@"%@", missingRay.origin);
    
    GHAssertLessThan(1000.0f, [sphere findIntersectionsForRay:missingRay withMaxDepth:1000.0f], @"Ray should intersect sphere %@", missingRay.origin);
}

@end
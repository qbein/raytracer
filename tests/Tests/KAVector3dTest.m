#import <GHUnit/GHUnit.h>

#import "KAVector3d.h"

@interface KAVector3dTest : GHTestCase { }

@property float x1, x2, y1, y2, z1, z2;
@property (retain) KAVector3d* v1;
@property (retain) KAVector3d* v2;

@end


@implementation KAVector3dTest

@synthesize x1, x2, y1, y2, z1, z2, v1, v2;

-(void)setUp {
    self.x1 = 10.0f;
    self.y1 = 15.0f;
    self.z1 = 95.0f;
    
    self.x2 = 27.0f;
    self.y2 = 62.5f;
    self.z2 = 33.33f;
    
    self.v1 = [[KAVector3d alloc] initWithX:x1 y:y1 andZ:z1];
    self.v2 = [[KAVector3d alloc] initWithX:x2 y:y2 andZ:z2];
}

-(void)tearDown {
    [self.v1 release];
    [self.v2 release];
}

-(void)testBasic {
    GHAssertEquals(v1.x, x1, nil);
    GHAssertEquals(v1.y, y1, nil);
    GHAssertEquals(v1.z, z1, nil);
}

-(void)testMultiplication {
    KAVector3d* vr = [v1 multiplyByVector:v2];
    
    GHAssertEquals(vr.x, (x1 * x2), nil);
    GHAssertEquals(vr.y, (y1 * y2), nil);
    GHAssertEquals(vr.z, (z1 * z2), nil);
    
    float factor = 17.77f;
    vr = [v2 multiplyByFloat:factor];
    
    GHAssertEquals(vr.x, (x2 * factor), nil);
    GHAssertEquals(vr.y, (y2 * factor), nil);
    GHAssertEquals(vr.z, (z2 * factor), nil);
}

-(void)testDivision {
    KAVector3d* vr = [v1 divideByVector:v2];
    
    GHAssertEquals(vr.x, (x1 / x2), nil);
    GHAssertEquals(vr.y, (y1 / y2), nil);
    GHAssertEquals(vr.z, (z1 / z2), nil);
    
    float factor = 14.32f;
    vr = [v2 divideByFloat:factor];
    
    GHAssertEquals(vr.x, (x2 / factor), nil);
    GHAssertEquals(vr.y, (y2 / factor), nil);
    GHAssertEquals(vr.z, (z2 / factor), nil);
}

-(void)testAddition {
    KAVector3d* vr = [v1 addVector:v2];
    
    GHAssertEquals(vr.x, (x1 + x2), nil);
    GHAssertEquals(vr.y, (y1 + y2), nil);
    GHAssertEquals(vr.z, (z1 + z2), nil);
    
    float add = 78.999f;
    vr = [v2 addFloat:add];
    
    GHAssertEquals(vr.x, (x2 + add), nil);
    GHAssertEquals(vr.y, (y2 + add), nil);
    GHAssertEquals(vr.z, (z2 + add), nil);
}

-(void)testSubstraction {
    KAVector3d* vr = [v1 substractVector:v2];
    
    GHAssertEquals(vr.x, (x1 - x2), nil);
    GHAssertEquals(vr.y, (y1 - y2), nil);
    GHAssertEquals(vr.z, (z1 - z2), nil);
    
    float sub = 78.999f;
    vr = [v2 substractFloat:sub];
    
    GHAssertEquals(vr.x, (x2 - sub), nil);
    GHAssertEquals(vr.y, (y2 - sub), nil);
    GHAssertEquals(vr.z, (z2 - sub), nil);
}

-(void)testDot {   
    GHAssertEquals((x1 + y1 + z1), [v1 dot], nil);
}

-(void)testDotProduct {
    GHAssertEquals(4373.85f, [v1 dotProduct:v2], nil);
}

-(void)testLength {
    // http://www.fundza.com/vectors/normalize/index.html
    
    GHAssertEquals(96.69539802906858f, [v1 length], nil);
    GHAssertEquals(75.80329082566271f, [v2 length], nil);
    
    KAVector3d* vt = [KAVector3d vectorWithX:3.0f y:1.0f andZ:2.0f];
    
    GHAssertEquals(3.7416573868f, [vt length], nil);
}

-(void)testNormalizedVector {
    // http://www.fundza.com/vectors/normalize/index.html
    
    float v1Length = [v1 length];
    
    float nx = v1.x / v1Length;
    float ny = v1.y / v1Length;
    float nz = v1.z / v1Length;
    
    KAVector3d* nv = [v1 normalizedVector];
    
    GHAssertEquals(nx, nv.x, nil);
    GHAssertEquals(ny, nv.y, nil);
    GHAssertEquals(nz, nv.z, nil);
}

@end

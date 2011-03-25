//
//  Scene.m
//  raytracer
//
//  Created by Kurt Aadnøy on 10.03.11.
//  Copyright 2011 aadnoy.info. All rights reserved.
//

#import "KAScene.h"
#import "Geometry/KASphere.h"
#import "KALight.h"
#import "KAMaterial.h"

@interface KAScene (hidden)
+(float)floatValueForKey:(NSString*)key inDictionary:(NSDictionary*)dict;
@end

@implementation KAScene

@synthesize lights;
@synthesize primitives;
@synthesize materials;
@synthesize width;
@synthesize height;
@synthesize scale;
@synthesize version;

+(float)floatValueForKey:(NSString*)key inDictionary:(NSDictionary*)dict {
    return [[dict objectForKey:key] floatValue];
}

-(id)init {
    if(![super init]) return nil;
    
    self.primitives = [[[NSMutableArray alloc] init] autorelease];
    self.lights = [[[NSMutableArray alloc] init] autorelease];
    self.materials = [[[NSMutableDictionary alloc] init] autorelease];
    
    return self;
}

-(id)initFromFile:(NSString *)filename {
    if(![self init]) return nil;
    
    NSLog(@"Parsing scene file %@", filename);
    
    // TODO: when encountering an error in init, is it best practice to simply return nil as done below?
    
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    
    NSError* error = nil;
    NSString* jsonString = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
    
    if(error) {
        NSLog(@"Error while reading scene file: %@", [error localizedDescription]);
        [parser release];
        return nil;
    }
    
    NSDictionary* scene = [parser objectWithString:jsonString error:&error];
    
    // TODO: are error handled correctly when releasing parser here?
    // Release parser as it's not required, simplifies error handling below
    [parser release];
    
    if(![scene isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Scene file did not parse as NSDictionary, invalid format. Was class [%@]", [scene class]);
        return nil;
    }
    
    if(error) {
        NSLog(@"Error parsing scene file: %@", [error localizedDescription]);
        return nil;
    }
    
    NSLog(@"%ld object(s) in scene", [[scene objectForKey:@"objects"] count]);
    
    if([[scene objectForKey:@"objects"] count] == 0) {
        NSLog(@"No objects in scene (JSON parse error?)");
        return nil;
    }
    
    self.version = [scene objectForKey:@"version"];
    
    if(![self.version isEqualToString:[NSString stringWithUTF8String:VERSION]]) {
        NSLog(@"Scene file could be incompatible with this raytracer version (scene v. %@, renderer v. %@)", self.version, [NSString stringWithUTF8String:VERSION]);
    }
    
    self.scale = 1.0f;
    if([scene objectForKey:@"scale"]) {
        self.scale = [[scene objectForKey:@"scale"] floatValue];
    }
    
    self.width = [[scene objectForKey:@"width"] intValue] * self.scale;
    self.height = [[scene objectForKey:@"height"] intValue] * self.scale;
    
    [[scene objectForKey:@"materials"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        KAMaterial* material = [[KAMaterial alloc] initWithRGBString:[obj objectForKey:@"diffuse"]
                                                        andReflection:[[obj objectForKey:@"reflection"] floatValue]];
        [self.materials setValue:[material autorelease] forKey:key];
    }];
    
    NSArray* objects = [scene objectForKey:@"objects"];
    BOOL* invalidObject = NO;
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* type = [obj objectForKey:@"type"];
        
        if([type isEqualToString:@"light"]) {
            KALight* light = [KALight alloc];
            
            [light initWithPosition:[KAPoint3d pointWithX:[KAScene floatValueForKey:@"x" inDictionary:obj] * self.scale 
                                                       y:[KAScene floatValueForKey:@"y" inDictionary:obj] * self.scale 
                                                    andZ:[KAScene floatValueForKey:@"z" inDictionary:obj] * self.scale]
                            andColor:[NSColor colorWithRGBString:[obj objectForKey:@"color"]]];
            
            [self.lights addObject:[light autorelease]];
        }
        else if([type isEqualToString:@"sphere"]) {
            KASphere* sphere = [KASphere alloc];
            
            [sphere initWithPosition:[KAPoint3d pointWithX:[KAScene floatValueForKey:@"x" inDictionary:obj]  * self.scale 
                                                       y:[KAScene floatValueForKey:@"y" inDictionary:obj] * self.scale
                                                    andZ:[KAScene floatValueForKey:@"z" inDictionary:obj] * self.scale]
                              radius:[KAScene floatValueForKey:@"r" inDictionary:obj] * self.scale
                         andMaterial:[materials objectForKey:[obj objectForKey:@"material"]]];
            
            [self.primitives addObject:[sphere autorelease]];
        }
        else {
            NSLog(@"Unknown object: %@", type);
            *stop = YES;
        }
    }];
    
    NSLog(@"Added %ld light(s): %@", [self.lights count], self.lights);
    NSLog(@"Added %ld primitive(s): %@", [self.primitives count], self.primitives);
    
    if(invalidObject) {
        [self.lights release];
        [self.primitives release];
        return nil;
    }
    
    return self;
}

- (void)dealloc {
    [self.lights release];
    [self.primitives release];
    [super dealloc];
}

@end

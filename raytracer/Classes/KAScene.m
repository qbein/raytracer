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

@interface KAScene (hidden)
+(float)floatValueForKey:(NSString*)key inDictionary:(NSDictionary*)dict;
@end

@implementation KAScene

@synthesize lights;
@synthesize primitives;
@synthesize width;
@synthesize height;
@synthesize version;

+(float)floatValueForKey:(NSString*)key inDictionary:(NSDictionary*)dict {
    return [[dict objectForKey:key] floatValue];
}

-(id)init {
    if(![super init]) return nil;
    
    self.primitives = [[[NSMutableArray alloc] init] autorelease];
    self.lights = [[[NSMutableArray alloc] init] autorelease];
    
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
    
    self.width = [[scene objectForKey:@"width"] intValue];
    self.height = [[scene objectForKey:@"height"] intValue];
    
    BOOL* invalidObject = NO;
    [[scene objectForKey:@"objects"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id object = nil;
 
        if([key isEqualToString:@"light"]) {
            object = [KALight alloc];
            [self.lights addObject:object];
        }
        else if([key isEqualToString:@"sphere"]) {
            object = [KASphere alloc];
            [self.primitives addObject:object];
        }
        else {
            NSLog(@"Unknown object: %@", key);
            *stop = YES;
        }
        
        if(object) {
            [object initWithPosition:[KAPoint pointWithX:[KAScene floatValueForKey:@"x" inDictionary:obj] 
                                                      y:[KAScene floatValueForKey:@"y" inDictionary:obj]
                                                   andZ:[KAScene floatValueForKey:@"y" inDictionary:obj]]
                              radius:[KAScene floatValueForKey:@"r" inDictionary:obj]
                            andColor:[NSColor colorWithRGBString:[obj objectForKey:@"color"]]];
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

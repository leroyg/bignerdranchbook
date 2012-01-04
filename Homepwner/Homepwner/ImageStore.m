//
//  ImageStore.m
//  Homepwner
//
//  Created by Tammer Saleh on 1/3/12.
//  Copyright (c) 2012 Thunderbolt Labs. All rights reserved.
//

#import "ImageStore.h"

static ImageStore *defaultImageStore = nil;

@implementation ImageStore

+(id)allocWithZone:(NSZone *)zone {
    return [self defaultImageStore];
}

+(ImageStore *)defaultImageStore {
    if (!defaultImageStore) {
        defaultImageStore = [[super allocWithZone:NULL] init];
    }
    return defaultImageStore;
}

-(id)init {
    if (defaultImageStore) {
        return defaultImageStore;
    }
    
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
}

- (void)setImage:(UIImage *)i forKey:(NSString *)s {
    [dictionary setObject:i forKey:s];
}

- (UIImage *)imageForKey:(NSString *)s {
    return [dictionary objectForKey:s];
}

- (void)deleteImageForKey:(NSString *)s {
    if (!s) { return; }
    [dictionary removeObjectForKey:s];
}

@end

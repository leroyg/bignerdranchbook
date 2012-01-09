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
    return self;
}

- (void)setImage:(UIImage *)i forKey:(NSString *)s {
    [dictionary setObject:i forKey:s];
    NSString *imagePath = pathInDocumentDirectory(s);
    NSData *d = UIImageJPEGRepresentation(i, 0.5);
    [d writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)s {
    UIImage *result = [dictionary objectForKey:s];
    if (!result) {
        result = [UIImage imageWithContentsOfFile:pathInDocumentDirectory(s)];
        if (result) {
            [dictionary setObject:result forKey:s];
        } else {
            NSLog(@"Error:  Could not find image %@", pathInDocumentDirectory(s));
        }
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)s {
    if (!s) { return; }
    [dictionary removeObjectForKey:s];
    NSString *path = pathInDocumentDirectory(s);
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

@end

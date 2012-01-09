//
//  PossessionStore.m
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "PossessionStore.h"
#import "Possession.h"
#import "ImageStore.h"

@implementation PossessionStore

static PossessionStore *defaultStore = nil;

+ (PossessionStore *)defaultStore {
    if (!defaultStore) {
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self defaultStore];
}

- (id)init {
    if (defaultStore) {
        return defaultStore;
    }
    self = [super init];
    return self;
}

- (NSArray *)allPossessions {
    [self fetchPossessionsIfNecessary];
    return allPossessions;
}

- (Possession *)createPossession {
    [self fetchPossessionsIfNecessary];
    Possession *p = [Possession randomPossession];
    [allPossessions addObject:p];
    return p;
}

- (void)removePossession:(Possession *)p {
    NSString *key = [p imageKey];
    [[ImageStore defaultImageStore] deleteImageForKey:key];
    [allPossessions removeObjectIdenticalTo:p];
}

- (void)movePossessionAtIndex:(int)from toIndex:(int)to {
    if (from == to) { return; }
    Possession *p = [allPossessions objectAtIndex:from];
    [allPossessions removeObjectAtIndex:from];
    [allPossessions insertObject:p atIndex:to];
}

- (NSString *)possessionArchivePath {
    return pathInDocumentDirectory(@"possessions.data");
}

- (BOOL)saveChanges {
    return [NSKeyedArchiver archiveRootObject:allPossessions toFile:[self possessionArchivePath]];
}

- (void)fetchPossessionsIfNecessary {
    if (!allPossessions) {
        NSString *path = [self possessionArchivePath];
        allPossessions = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    
    if (!allPossessions) {
        allPossessions = [[NSMutableArray alloc] init];
    }
}
@end

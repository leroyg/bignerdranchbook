//
//  PossessionStore.m
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "PossessionStore.h"
#import "Possession.h"

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
    if (self = [super init]) {
        allPossessions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allPossessions {
    return allPossessions;
}

- (Possession *)createPossession {
    Possession *p = [Possession randomPossession];
    [allPossessions addObject:p];
    return p;
}

- (void)removePossession:(Possession *)p {
    [allPossessions removeObjectIdenticalTo:p];
}

- (void)movePossessionAtIndex:(int)from toIndex:(int)to {
    if (from == to) { return; }
    Possession *p = [allPossessions objectAtIndex:from];
    [allPossessions removeObjectAtIndex:from];
    [allPossessions insertObject:p atIndex:to];
}
@end

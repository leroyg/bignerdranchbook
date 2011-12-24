//
//  PossessionStore.m
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "PossessionStore.h"
#import "Posession.h"

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

- (Posession *)createPossession {
    Posession *p = [Posession randomPosession];
    [allPossessions addObject:p];
    return p;
}

// NOT overriding retain/release/retainCount as per Page 179.  ARC will bitch.



@end

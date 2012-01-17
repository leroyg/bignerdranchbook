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

@synthesize allPossessions, allAssetTypes, context, model;

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
    [self setModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
    NSLog(@"Model: %@", [self model]);
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self model]];
    NSString *path = pathInDocumentDirectory(@"store.data");
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    
    if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
    context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:psc];
    [context setUndoManager:nil];
    
    return self;
}

- (NSArray *)allPossessions {
    [self fetchPossessionsIfNecessary];
    return allPossessions;
}

- (NSArray *)allAssetTypes {
    if (!allAssetTypes){
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"AssetType"];
        [request setEntity:e];
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        allAssetTypes = [result mutableCopy];
    }
    
    if ([allAssetTypes count] == 0) {
        NSManagedObject *type;
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:context];
        [type setValue:@"Furniture" forKey:@"label"];
        [allAssetTypes addObject:type];

        type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:context];
        [type setValue:@"Jewelry" forKey:@"label"];
        [allAssetTypes addObject:type];

        type = [NSEntityDescription insertNewObjectForEntityForName:@"AssetType" inManagedObjectContext:context];
        [type setValue:@"Electronics" forKey:@"label"];
        [allAssetTypes addObject:type];
    }
    return allAssetTypes;
}

- (Possession *)createPossession {
    [self fetchPossessionsIfNecessary];
    double order;
    if ([[self allPossessions] count] == 0) {
        order = 1.0;
    } else {
        order = [[[[self allPossessions] lastObject] orderingValue] doubleValue] + 1.0;
    }
    
    NSLog(@"Adding after %d items, order = %.2f", [[self allPossessions] count], order);
    Possession *p = [NSEntityDescription insertNewObjectForEntityForName:@"Possession" inManagedObjectContext:context];
    [p setOrderingValue:[NSNumber numberWithDouble:order]];
    [allPossessions addObject:p];
    return p;
}

- (void)removePossession:(Possession *)p {
    NSString *key = [p imageKey];
    [[ImageStore defaultImageStore] deleteImageForKey:key];
    [context deleteObject:p];
    [allPossessions removeObjectIdenticalTo:p];
}

- (void)movePossessionAtIndex:(int)from toIndex:(int)to {
    if (from == to) { return; }
    Possession *p = [allPossessions objectAtIndex:from];
    [allPossessions removeObjectAtIndex:from];
    [allPossessions insertObject:p atIndex:to];
    
    double lowerBound = 0.0;
    
    if (to > 0) {
        lowerBound = [[[allPossessions objectAtIndex:to - 1] orderingValue] doubleValue];
    } else {
        lowerBound = [[[allPossessions objectAtIndex:1] orderingValue] doubleValue] - 2.0;
    }
    
    double upperBound = 0.0;
    if (to < [allPossessions count] - 1) {
        upperBound = [[[allPossessions objectAtIndex:to + 1] orderingValue] doubleValue];
    } else {
        upperBound = [[[allPossessions objectAtIndex:to - 1] orderingValue] doubleValue] + 2.0;
    }
    
    NSNumber *n = [NSNumber numberWithDouble:(lowerBound + upperBound) / 2.0];
    NSLog(@"Moving to position %@", n);
    [p setOrderingValue:n];
}

- (NSString *)possessionArchivePath {
    return pathInDocumentDirectory(@"possessions.data");
}

- (BOOL)saveChanges {
    NSError *error = nil;
    BOOL successful = [context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

- (void)fetchPossessionsIfNecessary {
    if (!allPossessions) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Possession"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        
        [self setAllPossessions:[[NSMutableArray alloc] initWithArray:result]];
    }
}
@end

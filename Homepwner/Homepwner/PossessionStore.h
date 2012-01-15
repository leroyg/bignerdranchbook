//
//  PossessionStore.h
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Possession;

@interface PossessionStore : NSObject

@property(nonatomic, strong) NSMutableArray *allPossessions;
@property(nonatomic, strong) NSMutableArray *allAssetTypes;
@property(nonatomic, strong) NSManagedObjectContext *context;
@property(nonatomic, strong) NSManagedObjectModel *model;

+ (PossessionStore *)defaultStore;
- (BOOL)saveChanges;

#pragma mark Possessions
- (NSArray *)allPossessions;
- (Possession *)createPossession;
- (void)removePossession:(Possession *)p;
- (void)movePossessionAtIndex:(int)from toIndex:(int)to;
- (NSString *)possessionArchivePath;
- (void)fetchPossessionsIfNecessary;

#pragma mark Asset Types
- (NSArray *)allAssetTypes;

@end

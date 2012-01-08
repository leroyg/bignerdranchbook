//
//  PossessionStore.h
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Possession;

@interface PossessionStore : NSObject
{
    NSMutableArray *allPossessions;
}
+ (PossessionStore *)defaultStore;
- (NSArray *)allPossessions;
- (Possession *)createPossession;
- (void)removePossession:(Possession *)p;
- (void)movePossessionAtIndex:(int)from toIndex:(int)to;
- (NSString *)possessionArchivePath;
- (BOOL)saveChanges;
- (void)fetchPossessionsIfNecessary;
@end

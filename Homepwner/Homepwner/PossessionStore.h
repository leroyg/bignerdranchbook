//
//  PossessionStore.h
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Posession;

@interface PossessionStore : NSObject
{
    NSMutableArray *allPossessions;
}
+ (PossessionStore *)defaultStore;
- (NSArray *)allPossessions;
- (Posession *)createPossession;

@end

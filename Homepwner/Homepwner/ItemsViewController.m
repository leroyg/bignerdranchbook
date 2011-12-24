//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "ItemsViewController.h"
#import "Possession.h"
#import "PossessionStore.h"

@implementation ItemsViewController

- (id)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        for (int i = 0; i < 10; i++) {
//            [[PossessionStore
        }
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

@end

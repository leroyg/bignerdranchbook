//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemDetailViewController.h"

@interface ItemsViewController : UITableViewController <ItemDetailViewControllerDelegate>

- (IBAction)addNewPossession:(id)sender;

@end

//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemsViewController : UITableViewController
{
    IBOutlet UIView *headerView;
}
- (UIView *)headerView;
- (IBAction)addNewPossession:(id)sender
- (IBAction)toggleEditingMode:(id)sender

@end

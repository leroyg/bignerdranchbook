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

- (id)init {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPossession:)];
        [[self navigationItem] setRightBarButtonItem:bbi];
        [[self navigationItem] setTitle:@"Possessions"];
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemDetailViewController *detailViewController = [[ItemDetailViewController alloc] init];
    
    NSArray *possessions = [[PossessionStore defaultStore] allPossessions];
    [detailViewController setPossession:[possessions objectAtIndex:[indexPath row]]];
    
    [[self navigationController] pushViewController:detailViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[PossessionStore defaultStore] allPossessions] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    Possession *p =[[[PossessionStore defaultStore] allPossessions] objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[p description]];
    return cell;
}

- (IBAction)addNewPossession:(id)sender {
    [[PossessionStore defaultStore] createPossession];
    [[self tableView] reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PossessionStore *ps = [PossessionStore defaultStore];
        NSArray *possessions = [ps allPossessions];
        Possession *p = [possessions objectAtIndex:[indexPath row]];
        [ps removePossession:p];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[PossessionStore defaultStore] movePossessionAtIndex:[sourceIndexPath row] toIndex:[destinationIndexPath row]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    }
    
}

@end

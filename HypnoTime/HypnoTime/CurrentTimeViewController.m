//
//  CurrentTimeViewController.m
//  HypnoTime
//
//  Created by Tammer Saleh on 12/23/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "CurrentTimeViewController.h"

@implementation CurrentTimeViewController

- (id)init
{
    [super initWithNibName:nil bundle:nil];
    if (self) {
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Time"];
        [tbi setImage:[UIImage imageNamed:@"Time.png"]];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Loaded the view for CurrentTimeViewController");
}

@end

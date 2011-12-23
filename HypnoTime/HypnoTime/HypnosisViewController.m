//
//  HypnosisViewController.m
//  HypnoTime
//
//  Created by Tammer Saleh on 12/23/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "HypnosisViewController.h"

@implementation HypnosisViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Hypnosis"];
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
    NSLog(@"Loaded the view for HypnosisViewController");
    [[self view] setBackgroundColor:[UIColor yellowColor]];
}

@end

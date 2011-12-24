//
//  MapKitViewController.m
//  HypnoTime
//
//  Created by Tammer Saleh on 12/23/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "MapKitViewController.h"
#import <MapKit/MapKit.h>

@implementation MapKitViewController
- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Map"];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self init];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D location = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 250, 250);
    [mapView setRegion:region animated:YES];
}

- (void)loadView
{
    MKMapView *v = [[MKMapView alloc] initWithFrame:CGRectZero];
    [v setShowsUserLocation:YES];
    [v setDelegate:self];
    [self setView:v];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Loaded the view for MapKitViewController");
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"MapKitViewController will appear");
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"MapKitViewController will appear");
    [super viewWillDisappear:animated];
}

@end

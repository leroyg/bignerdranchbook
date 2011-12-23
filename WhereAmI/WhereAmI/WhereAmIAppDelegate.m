//
//  WhereAmIAppDelegate.m
//  WhereAmI
//
//  Created by Tammer Saleh on 12/19/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "WhereAmIAppDelegate.h"
#import "MapPoint.h"

@implementation WhereAmIAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [worldView setShowsUserLocation:YES];
    [[self window] makeKeyAndVisible];
    return YES;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D location = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 250, 250);
    [worldView setRegion:region animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self findLocation];
    [textField resignFirstResponder];
    return YES;
}

- (void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTextField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)location
{
    CLLocationCoordinate2D coord = [location coordinate];
    
    [locationManager stopUpdatingLocation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        NSString *text = [locationTextField text];
        MapPoint *mp = [[MapPoint alloc] initWithCoordinate:coord title:text];
        if ([placemarks count] > 0){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            [mp setTitle:[NSString stringWithFormat:@"%@ %@", text, [placemark name]]];
        }
       
        [worldView addAnnotation:mp];
        
        [locationTextField setText:@""];
        [activityIndicator stopAnimating];
        [locationTextField setHidden:NO];
    }];    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    if (t < -180) {
        return;
    }
    [self foundLocation:newLocation];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end

//
//  WhereAmIAppDelegate.h
//  WhereAmI
//
//  Created by Tammer Saleh on 12/19/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereAmIAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTextField;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

- (void)findLocation;
- (void)foundLocation:(CLLocation *)location;

@end

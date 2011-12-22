//
//  WhereAmIAppDelegate.h
//  WhereAmI
//
//  Created by Tammer Saleh on 12/19/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WhereAmIAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

@end

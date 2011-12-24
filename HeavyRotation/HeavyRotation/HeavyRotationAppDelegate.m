//
//  HeavyRotationAppDelegate.m
//  HeavyRotation
//
//  Created by Tammer Saleh on 12/24/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "HeavyRotationAppDelegate.h"
#import "HeavyViewController.h"

@implementation HeavyRotationAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIDevice *device = [UIDevice currentDevice];
    [device beginGeneratingDeviceOrientationNotifications];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:device];

    HeavyViewController *hvc = [[HeavyViewController alloc] init];
    [[self window] setRootViewController:hvc];
    
    [[self window] makeKeyAndVisible];
    return YES;
}

- (void)orientationChanged:(NSNotification *)note
{
    NSLog(@"orientationChanged: %d", [[note object] orientation]);
}


@end

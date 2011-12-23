//
//  HypnotizerAppDelegate.h
//  Hypnotizer
//
//  Created by Tammer Saleh on 12/22/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HypnosisView;

@interface HypnotizerAppDelegate : UIResponder <UIApplicationDelegate, UIScrollViewDelegate>
{
    HypnosisView *view;
}
@property (strong, nonatomic) IBOutlet UIWindow *window;

@end

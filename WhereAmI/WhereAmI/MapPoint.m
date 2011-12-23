//
//  MapPoint.m
//  WhereAmI
//
//  Created by Tammer Saleh on 12/22/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint
@synthesize coordinate, title, placemark;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (self) {
        coordinate = c;
        [self setTitle:t];
    }
    return self;
}



@end

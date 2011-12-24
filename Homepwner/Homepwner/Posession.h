//
//  Posession.h
//  RandomPosessions
//
//  Created by Tammer Saleh on 12/16/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Posession : NSObject
{
}

+ (id)randomPosession;

- (id)initWithPosessionName:(NSString *)name
             valueInDollars:(int)value
               serialNumber:(NSString *)sNumber;

@property (strong, nonatomic) NSString *posessionName;
@property (strong, nonatomic) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (strong, readonly, nonatomic) NSDate *dateCreated;

@end

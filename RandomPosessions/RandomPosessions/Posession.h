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
    NSString *posessionName;
    NSString *serialNumber;
    int valueInDollars;
    NSDate *dateCreated;
}

+ (id)randomPosession;

- (id)initWithPosessionName:(NSString *)name
             valueInDollars:(int)value
               serialNumber:(NSString *)sNumber;

- (void)setPosessionName:(NSString *)str;
- (NSString *)posessionName;

- (void)setSerialNumber:(NSString *)str;
- (NSString *)serialNumber;

- (void)setValueInDollars:(int)i;
- (int)valueInDollars;

- (NSDate *)dateCreated;

@end

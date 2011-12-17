//
//  Posession.m
//  RandomPosessions
//
//  Created by Tammer Saleh on 12/16/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "Posession.h"

@implementation Posession

- (id)initWithPosessionName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber
{
    self = [super init];
    if (self) {
        [self setPosessionName:name];
        [self setValueInDollars:value];
        [self setSerialNumber:sNumber];
        dateCreated = [[NSDate alloc] init];
    }
    return self;        
}

- (id)init
{
    return [self initWithPosessionName:@"Unknown" 
                        valueInDollars:0 
                          serialNumber:@"Unknown"];
}

- (void)setPosessionName:(NSString *)str
{
    posessionName = str;
}

- (NSString *)posessionName
{
    return posessionName;
}

- (void)setSerialNumber:(NSString *)str
{
    serialNumber = str;
}

- (NSString *)serialNumber
{
    return serialNumber;
}

- (void)setValueInDollars:(int)i
{
    valueInDollars = i;
}

- (int)valueInDollars
{
    return valueInDollars;
}

- (NSDate *)dateCreated
{
    return dateCreated;
}

- (NSString *)description
{
    return @"%@ (%@) $%d [%@]", posessionName, serialNumber, value, dateCreated;
}

@end

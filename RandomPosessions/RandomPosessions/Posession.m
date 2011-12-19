//
//  Posession.m
//  RandomPosessions
//
//  Created by Tammer Saleh on 12/16/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "Posession.h"

@implementation Posession


+ (id)randomPosession
{
    NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy", @"Rusty", @"Shitty", nil];
    NSArray *randomNounList = [NSArray arrayWithObjects:@"boobie", @"penis", @"asshole", nil];
    int adjectiveIndex = rand() % [randomAdjectiveList count];
    int nounIndex = rand() % [randomNounList count];
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            [randomAdjectiveList objectAtIndex:adjectiveIndex],
                            [randomNounList objectAtIndex:nounIndex]];
    int randomValue = rand() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10,
                                    'A' + rand() % 26,
                                    '0' + rand() % 10];
    Posession *newPosession = [[self alloc] 
                               initWithPosessionName:randomName 
                               valueInDollars:randomValue 
                               serialNumber:randomSerialNumber];
    return newPosession;
                                    
}

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
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@) $%d [%@]", posessionName, serialNumber, valueInDollars, dateCreated];
    return descriptionString;
}

@end

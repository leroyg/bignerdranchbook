//
//  Possession.m
//  RandomPossessions
//
//  Created by Tammer Saleh on 12/16/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "Possession.h"

@implementation Possession
@synthesize possessionName, serialNumber, valueInDollars, dateCreated, imageKey;

+ (id)randomPossession {
    NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Red", @"Blue", @"Purple", nil];
    NSArray *randomNounList = [NSArray arrayWithObjects:@"car", @"truck", @"boat", nil];
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
    Possession *newPossession = [[self alloc] 
                               initWithPossessionName:randomName 
                               valueInDollars:randomValue 
                               serialNumber:randomSerialNumber];
    return newPossession;
                                    
}

- (id)initWithCoder:(NSCoder *)decoder {
    [self setPossessionName:[decoder decodeObjectForKey:@"possessionName"]];
    [self setSerialNumber:[decoder decodeObjectForKey:@"serialNumber"]];
    [self setImageKey:[decoder decodeObjectForKey:@"imageKey"]];
    [self setValueInDollars:[decoder decodeObjectForKey:@"valueInDollars"]];
    dateCreated = [decoder decodeObjectForKey:@"dateCreated"];
}
     

- (id)initWithPossessionName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber {
    self = [super init];
    if (self) {
        [self setPossessionName:name];
        [self setValueInDollars:value];
        [self setSerialNumber:sNumber];
        dateCreated = [[NSDate alloc] init];
    }
    return self;        
}

- (id)init {
    return [self initWithPossessionName:@"Unknown" 
                         valueInDollars:0 
                           serialNumber:@"Unknown"];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@) $%d [%@]", possessionName, serialNumber, valueInDollars, dateCreated];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:possessionName forKey:@"possessionName"];
    [aCoder encodeObject:serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:imageKey forKey:@"imageKey"];
    [aCoder encodeInt:valueInDollars forKey:@"valueInDollars"];
}
@end

//
//  Possession.h
//  RandomPossessions
//
//  Created by Tammer Saleh on 12/16/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Possession : NSObject <NSCoding>

+ (id)randomPossession;
+ (CGSize)thumbnailSize;

@property(nonatomic, strong  ) NSString *possessionName;
@property(nonatomic, strong  ) NSString *serialNumber;
@property(nonatomic          ) int       valueInDollars;
@property(nonatomic, strong) NSDate   *dateCreated;
@property(nonatomic, strong  ) NSString *imageKey;
@property(nonatomic, strong) UIImage  *thumbnail;
@property(nonatomic, strong  ) NSData   *thumbnailData;

- (id)initWithPossessionName:(NSString *)name
             valueInDollars:(int)value
               serialNumber:(NSString *)sNumber;

- (void)setThumbnailDataFromImage:(UIImage *)image;

@end

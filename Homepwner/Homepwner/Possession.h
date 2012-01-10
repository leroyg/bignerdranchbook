//
//  Possession.h
//  Homepwner
//
//  Created by Tammer Saleh on 1/10/12.
//  Copyright (c) 2012 Thunderbolt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AssetType;

@interface Possession : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * imageKey;
@property (nonatomic, retain) NSNumber * orderingValue;
@property (nonatomic, retain) NSString * possessionName;
@property (nonatomic, retain) NSString * serialNumber;
@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic, retain) NSData * thumbnailData;
@property (nonatomic, retain) NSNumber * valueInDollars;
@property (nonatomic, retain) AssetType *assetType;

+ (CGSize)thumbnailSize;

- (void)setThumbnailDataFromImage:(UIImage *)image;

@end

//
//  Possession.m
//  Homepwner
//
//  Created by Tammer Saleh on 1/10/12.
//  Copyright (c) 2012 Thunderbolt Labs. All rights reserved.
//

#import "Possession.h"
#import "AssetType.h"


@implementation Possession

@dynamic dateCreated;
@dynamic imageKey;
@dynamic orderingValue;
@dynamic possessionName;
@dynamic serialNumber;
@dynamic thumbnail;
@dynamic thumbnailData;
@dynamic valueInDollars;
@dynamic assetType;

+ (CGSize)thumbnailSize {
    return CGSizeMake(40, 40);
}

- (void)setThumbnailDataFromImage:(UIImage *)image {
    CGSize originalImageSize = [image size];
    
    CGRect newRect;
    newRect.origin = CGPointZero;
    newRect.size = [[self class] thumbnailSize];
    
    float ratio = MAX(newRect.size.width / originalImageSize.width, newRect.size.height / originalImageSize.height);
    
    UIGraphicsBeginImageContext(newRect.size);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    
    CGRect projectRect;
    projectRect.size.width = ratio * originalImageSize.width;
    projectRect.size.height = ratio * originalImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.width - projectRect.size.width) / 2.0;
    [image drawInRect:projectRect];
    
    UIImage *small = UIGraphicsGetImageFromCurrentImageContext();
    [self setThumbnail:small];
    [self setThumbnailData:UIImagePNGRepresentation(small)];
    
    UIGraphicsEndImageContext();
}

@end

//
//  ImageStore.h
//  Homepwner
//
//  Created by Tammer Saleh on 1/3/12.
//  Copyright (c) 2012 Thunderbolt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}
+(ImageStore *)defaultImageStore;

-(void)setImage:(UIImage *)i forKey:(NSString *)s;
-(UIImage *)imageForKey:(NSString *)s;
-(void)deleteImageForKey:(NSString *)s;

@end

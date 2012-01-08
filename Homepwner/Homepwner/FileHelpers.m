//
//  FileHelpers.m
//  Homepwner
//
//  Created by Tammer Saleh on 1/7/12.
//  Copyright (c) 2012 Thunderbolt Labs. All rights reserved.
//

#import "FileHelpers.h"

NSString *pathInDocumentDirectory(NSString *filename) {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:filename];
}
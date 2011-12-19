//
//  main.m
//  RandomPosessions
//
//  Created by Tammer Saleh on 12/16/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Posession.h"

int main (int argc, const char * argv[])
{

    @autoreleasepool {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 10; i++) {
            Posession *p = [Posession randomPosession];
            [items addObject:p];
        }
        
        for (Posession *item in items) {
            NSLog(@"%@", item);            
        }        
    }
    return 0;
}


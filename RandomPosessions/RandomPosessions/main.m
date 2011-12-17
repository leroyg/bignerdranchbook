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
        [items addObject:@"one"];
        [items addObject:@"two"];
        [items addObject:@"three"];
        [items insertObject:@"zero" atIndex:0];
        
        for(int i = 0; i < [items count]; i++) {
            NSLog(@"%@", [items objectAtIndex:i]);
            
        }
        
        Posession *p = [[Posession alloc] init];
        [p setPosessionName:@"Red Sofa"];
        [p setSerialNumber:@"1234"];
        [p setValueInDollars:32];
        
        NSLog(@"%@", p);
    }
    return 0;
}


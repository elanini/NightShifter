//
//  main.m
//  nightshifter
//
//  Created by Eric Lanini on 6/12/17.
//  Copyright © 2017 Eric Lanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NightShifterCommandLine.h"



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray <NSString*>*args = [[NSProcessInfo processInfo] arguments];
        NightShifterCommandLine *cmd = [[NightShifterCommandLine alloc] initWithArgs:args];
        BOOL ret = [cmd parse];
        if (ret == NO) {
            return 1;
        }
        
        return [cmd run];
    }
    return 0;
}



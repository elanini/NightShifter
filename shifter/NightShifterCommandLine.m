//
//  NightShifterCommandLine.m
//  NightShifter
//
//  Created by Eric Lanini on 6/12/17.
//  Copyright © 2017 Eric Lanini. All rights reserved.
//

#import "NightShifterCommandLine.h"
#import "../CBBlueLightClient.h"

typedef enum {
    NSVerbGet,
    NSVerbSet,
    NSVerbOn,
    NSVerbOff
}NSVerbType;

@interface NightShifterCommandLine ()

@property (strong) CBBlueLightClient *blueLight;
@property (assign) NSVerbType verb;
@property (assign) float amount;
@property (strong) NSArray <NSString*> *args;

@end

@implementation NightShifterCommandLine

-(instancetype)initWithArgs:(NSArray<NSString*>*)args {
    self = [super init];
    if (!self) {
        return self;
    }
    self.blueLight = [[CBBlueLightClient alloc] init];
    self.args = args;
    return self;
}

-(int)run {
    switch (self.verb) {
        case NSVerbOn: return [self.blueLight setEnabled:YES];
        case NSVerbOff: return [self.blueLight setEnabled:NO];
        case NSVerbSet: return [self.blueLight setStrength:self.amount commit:YES];
        case NSVerbGet: {
            float str;
            BOOL ret = [self.blueLight getStrength:&str];
            if (ret) {
                printf("%d\n", (int)round(str*100.0));
            }
            return ret;
        }
    }
}

void perr(char *str) {
    fprintf(stderr, "%s\n", str);
}

-(BOOL)parse {
    if ([self.args count] == 1) {
        perr("requires verb");
        return NO;
    }
    if  ([self.args[1] isEqualToString:@"set"]) {
        if ([self.args count] == 3) {
            self.verb = NSVerbSet;
        } else {
            perr("set requires a number in range 0 to 100");
            return NO;
        }
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.minimum = @0;
        f.maximum = @100;
        NSNumber *num = [f numberFromString:self.args[2]];
        if (!num) {
            perr("set requires a number in range 0 to 100");
            return NO;
        }
        self.amount = [num floatValue]/100.0;
        return YES;
    }
    
    if ([self.args[1] isEqualToString:@"get"]) {
        self.verb = NSVerbGet;
    } else if  ([self.args[1] isEqualToString:@"on"]) {
        self.verb = NSVerbOn;
    } else if  ([self.args[1] isEqualToString:@"off"]) {
        self.verb = NSVerbOff;
    } else {
        perr("allowed verbs on, off, set, get");
        return NO;
    }
    return YES;
}

@end

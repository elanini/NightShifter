//
//  NightShifterCommandLine.h
//  NightShifter
//
//  Created by Eric Lanini on 6/12/17.
//  Copyright © 2017 Eric Lanini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NightShifterCommandLine : NSObject

-(instancetype)initWithArgs:(NSArray<NSString*>*)args;
-(BOOL)parse;
-(int)run;
@end

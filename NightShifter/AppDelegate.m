//
//  AppDelegate.m
//  NightShifter
//
//  Created by Eric Lanini on 6/11/17.
//  Copyright © 2017 Eric Lanini. All rights reserved.
//

#import "AppDelegate.h"
#import "NightShiftController.h"


@interface AppDelegate ()
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSPopover *popover;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    self.statusItem.title = @"☀";
    
    self.statusItem.button.action = @selector(togglePopover:);
    // Insert code here to initialize your application
    self.popover = [[NSPopover alloc] init];
    [self.popover setContentViewController:[[NightShiftController alloc] initWithNibName:@"NightShiftController" bundle:nil]];
}

-(void)showPopover {
    NSButton *b = self.statusItem.button;
    [self.popover showRelativeToRect:b.bounds ofView:b preferredEdge:NSMinYEdge];
}

-(void)closePopover {
    [self.popover performClose:nil];
}

-(void)togglePopover:(id)sender {
    if (self.popover.shown) {
        [self closePopover];
    } else {
        [self showPopover];
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end

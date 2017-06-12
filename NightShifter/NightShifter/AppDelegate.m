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
@property (nonatomic, strong) NSClickGestureRecognizer *gesture;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    self.statusItem.title = @"☀";
    
    self.statusItem.button.action = @selector(togglePopover:);
    NSClickGestureRecognizer *gesture = [[NSClickGestureRecognizer alloc] init];
    gesture.buttonMask = 0x2;
    gesture.target = self;
    gesture.numberOfClicksRequired = 1;
    gesture.action = @selector(rightClickAction:);
    [self.statusItem.button addGestureRecognizer:gesture];
    self.gesture = gesture;
    
    
    self.popover = [[NSPopover alloc] init];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
    
    
    [self.popover setBehavior:NSPopoverBehaviorApplicationDefined];
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseDown|NSEventMaskRightMouseDown
                                           handler:^(NSEvent * _Nonnull e) {
        [self closePopover];
    }];
    
    [self.popover setContentViewController:[[NightShiftController alloc]
                                            initWithNibName:@"NightShiftController" bundle:nil]];
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

-(void)rightClickAction:(id)sender {
    NSLog(@"right click action");
//    [NSApp terminate:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end

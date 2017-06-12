//
//  NightShiftController.m
//  NightShifter
//
//  Created by Eric Lanini on 6/11/17.
//  Copyright © 2017 Eric Lanini. All rights reserved.
//

#import "NightShiftController.h"
#import "CBBlueLightClient.h"




@interface NightShiftController ()

@property (weak) IBOutlet NSButton *toggleButton;
@property (weak) IBOutlet NSSlider *strengthSlider;
@property (strong) CBBlueLightClient *blueLight;

@end

@implementation NightShiftController
- (IBAction)sliderChanged:(id)sender {
    [self.blueLight setStrength:self.strengthSlider.floatValue commit:YES];
}

- (IBAction)toggleEnable:(id)sender {
    if (self.toggleButton.state == NSOnState) {
        [self.blueLight setEnabled:YES];
        [self.strengthSlider setEnabled:YES];
    } else {
        [self.blueLight setEnabled:NO];
        [self.strengthSlider setEnabled:NO];
    }
}

- (void)viewDidLoad {
    self.blueLight = [[CBBlueLightClient alloc] init];
    
    
    if (![CBBlueLightClient supportsBlueLightReduction]) {
        self.toggleButton.enabled = NO;
        self.strengthSlider.enabled = NO;
    }
    
    StatusData status;
    [self.blueLight getBlueLightStatus:&status];
    if (status.enabled) {
        [self.toggleButton setState:NSOnState];
    } else {
        [self.toggleButton setState:NSOffState];
        [self.strengthSlider setEnabled:NO];
    }
    
    
    float currVal;
    [self.blueLight getStrength:&currVal];
    [self.strengthSlider setFloatValue:currVal];
    [super viewDidLoad];
    // Do view setup here.
}

@end

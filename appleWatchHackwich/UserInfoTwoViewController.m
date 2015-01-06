//
//  UserInfoTwoViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "UserInfoTwoViewController.h"

@interface UserInfoTwoViewController ()

@end

@implementation UserInfoTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.switchADDSwitch setOn:NO animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    [currentSettings setInteger:self.ADD forKey:@"CurrentFromUserInfoTwoVCADD"];
    NSLog(@"Passing UI2VC Current ADD %ld /n", (long)self.ADD);
    [currentSettings setInteger:self.Dys forKey:@"CurrentFromUserInfoTwoDys"];
    NSLog(@"Passing UI2VC Current Dys %ld", (long)self.Dys);
    [currentSettings synchronize];
}

- (IBAction)onADDSwitch:(UISwitch *)sender {
    if ([self.switchADDSwitch isOn]) {
        [self.switchADDSwitch setOn:YES animated:YES];
        self.ADD = 1;
        NSLog(@"ADD Switch is on %ld", (long)self.ADD);
    } else {
        [self.switchADDSwitch setOn:NO animated:YES];
        self.ADD = 0;
        NSLog(@"ADD Switch is off %ld", (long)self.ADD);
    }
}

- (IBAction)onDyslexiaSwitch:(UISwitch *)sender {
    if ([self.switchDyslexiaSwitch isOn]) {
        [self.switchDyslexiaSwitch setOn:YES animated:YES];
        self.Dys = 1;
        NSLog(@"dyslexia Switch is on %ld", (long)self.Dys);
    } else {
        [self.switchDyslexiaSwitch setOn:NO animated:YES];
        self.Dys = 0;
        NSLog(@"dyslexia Switch is off %ld", (long)self.Dys);
    }
}

@end
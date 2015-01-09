//
//  UserInfoTwoViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "UserInfoTwoViewController.h"
#import "UserInfoOneViewController.h"

@interface UserInfoTwoViewController ()

@end

@implementation UserInfoTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"VIEW DID LOAD US2VC");
    [self.switchADDSwitch setOn:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self passData];
}

- (IBAction)onADDSwitch:(UISwitch *)sender {
    if ([self.switchADDSwitch isOn]) {
        [self getData];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Age & Gender"
                                                        message:@"Make sure you set the age AND gender first"
                                                       delegate:self
                                              cancelButtonTitle:@"Got it"
                                              otherButtonTitles:nil, nil ];

        NSLog(@"Page one AGE %ld", self.age);
        NSLog(@"Page one Gen %ld", self.gender);

        if (self.age == 0 || self.gender == 0) {
            [alert show];
            [self.switchADDSwitch setOn:NO animated:YES];
            self.ADD = 0;
        } else {
            [self.switchADDSwitch setOn:YES animated:YES];
            self.ADD = 1;
            NSLog(@"ADD Switch is on %ld", (long)self.ADD);
        }

    } else {
        [self.switchADDSwitch setOn:NO animated:YES];
        self.ADD = 0;
        NSLog(@"ADD Switch is off %ld", (long)self.ADD);
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];

    NSLog(@"US2VC view will appear");

    NSLog(@"Age %ld Gender %ld", self.age, self.gender);
    if (self.age == 0 || self.gender == 0) {
        [self.switchADDSwitch setOn:NO animated:NO];
        [self.switchDyslexiaSwitch setOn:NO animated:NO];
        self.ADD = 0;
        self.Dys = 0;
    }
}

- (IBAction)onDyslexiaSwitch:(UISwitch *)sender {
    if ([self.switchDyslexiaSwitch isOn]) {

        [self getData];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Age & Gender"
                                                        message:@"Make sure you set the age AND gender first"
                                                       delegate:self
                                              cancelButtonTitle:@"Got it"
                                              otherButtonTitles:nil, nil ];

        NSLog(@"Page one AGE %ld", self.age);
        NSLog(@"Page one Gen %ld", self.gender);

        if (self.age == 0 || self.gender == 0) {
            [alert show];
            [self.switchDyslexiaSwitch setOn:NO animated:YES];
            self.Dys = 0;
        } else {
            [self.switchDyslexiaSwitch setOn:YES animated:YES];
            self.Dys = 1;
            NSLog(@"Dys Switch is on %ld", (long)self.Dys);
        }
    }
}

-(void)passData{
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    [currentSettings setInteger:self.ADD forKey:@"CurrentADD"];
    [currentSettings setInteger:self.Dys forKey:@"CurrentDys"];
    [currentSettings synchronize];

    NSLog(@"Passing UI2VC Current ADD %ld /n", (long)self.ADD);
    NSLog(@"Passing UI2VC Current Dys %ld", (long)self.Dys);
}

-(void)getData{
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];

    NSInteger newAge = [currentSettings integerForKey:@"CurrentAge"];
    NSInteger newGender = [currentSettings integerForKey:@"CurrentGender"];
    
    self.age = newAge;
    self.gender = newGender;
}


@end
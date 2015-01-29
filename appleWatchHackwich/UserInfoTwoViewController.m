//
//  UserInfoTwoViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "UserInfoTwoViewController.h"
#import "UserInfoOneViewController.h"

@interface UserInfoTwoViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation UserInfoTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"VIEW DID LOAD US2VC");
    [self.switchADDSwitch setOn:NO animated:YES];
    self.ADHD = 0;

    self.disabilities = [[NSMutableArray alloc] initWithObjects:@"A.D.D", @"A.D.H.D",@"Dyslexia",@"Test1", nil];
}

- (IBAction)onADHDSwitch:(UISwitch *)sender {
    if ([self.SwtchADHDSwitch isOn]) {
        [self getData];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Age & Gender"
                                                        message:@"Make sure you set the age AND gender first"
                                                       delegate:self
                                              cancelButtonTitle:@"Got it"
                                              otherButtonTitles:nil, nil ];

        NSLog(@"Page one AGE %ld", (long)self.age);
        NSLog(@"Page one Gen %ld", (long)self.gender);

        if (self.age == 0 || self.gender == 0 /*self.sleep == 0*/) {
            [alert show];
            [self.SwtchADHDSwitch setOn:NO animated:YES];
            self.ADHD = 0;
        } else {
            [self.SwtchADHDSwitch setOn:YES animated:YES];
            self.ADHD = 1;
            NSLog(@"ADD Switch is on %ld", (long)self.ADHD);
        }
    } else {
        [self.SwtchADHDSwitch setOn:NO animated:YES];
        self.ADHD = 0;
        NSLog(@"ADD Switch is off %ld", (long)self.ADHD);
    }
    [self storeData];
}


- (IBAction)onDyslexiaSwitch:(UISwitch *)sender {
    if ([self.switchDyslexiaSwitch isOn]) {

        [self getData];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Age & Gender"
                                                        message:@"Make sure you set the age AND gender first"
                                                       delegate:self
                                              cancelButtonTitle:@"Got it"
                                              otherButtonTitles:nil, nil ];

        NSLog(@"Page one AGE %ld", (long)self.age);
        NSLog(@"Page one Gen %ld", (long)self.gender);

        if (self.age == 0 || self.gender == 0) {
            [alert show];
            [self.switchDyslexiaSwitch setOn:NO animated:YES];
            self.Dys = 0;
        } else {
            [self.switchDyslexiaSwitch setOn:YES animated:YES];
            self.Dys = 1;
            NSLog(@"Dys Switch is on %ld", (long)self.Dys);
        }
    } else {
        [self.switchDyslexiaSwitch setOn:NO animated:YES];
        self.Dys = 0;
        NSLog(@"Dys Switch is off %ld", (long)self.Dys);
    }
    [self storeData];
}

- (IBAction)onADDSwitch:(UISwitch *)sender {
    if ([self.switchADDSwitch isOn]) {
        [self getData];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Set Age & Gender"
                                                        message:@"Make sure you set the age AND gender first"
                                                       delegate:self
                                              cancelButtonTitle:@"Got it"
                                              otherButtonTitles:nil, nil ];

        NSLog(@"Page one AGE %ld", (long)self.age);
        NSLog(@"Page one Gen %ld", (long)self.gender);

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
    [self storeData];
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"US2VC view will appear");

    [self getData];

    NSLog(@"Age %ld Gender %ld", (long)self.age, (long)self.gender);
    NSLog(@"Study %ld Break %ld", (long)self.studySliderInt, (long)self.breakSliderInt);

    if (self.age == 0 || self.gender == 0 /*|| self.slepp == 0*/) {
        [self resetSwitches];
    } else if (self.studySliderInt == !0 || self.breakSliderInt == !0 ) {
        [self resetSwitches];
    }

    if (self.ADD == 1) {
        [self.switchADDSwitch setOn:YES animated:YES];
    }
    if (self.ADHD == 1) {
        [self.SwtchADHDSwitch setOn:YES animated:YES];
    }
    if (self.Dys == 1){
        [self.switchDyslexiaSwitch setOn:YES animated:YES];
    }
}

-(void)resetSwitches{
    [self.switchADDSwitch setOn:NO animated:YES];
    [self.switchDyslexiaSwitch setOn:NO animated:YES];
    [self.SwtchADHDSwitch setOn:NO animated:YES];
    self.ADD = 0;
    self.Dys = 0;
    self.ADHD = 0;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self storeData];
}

#pragma mark TableView Helper Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.disabilities count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCellID"];
    UISwitch *theSwitch = nil;

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCellID"];
        theSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        theSwitch.tag = 100;
        [theSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:theSwitch];

        CGRect switchFrame = theSwitch.frame;
        switchFrame.origin.x = 250;
        switchFrame.origin.y = 20;
        theSwitch.frame = switchFrame;

        CGRect labelFrame = cell.frame;
        labelFrame.origin.x = -123;
        labelFrame.origin.y = 0;
        cell.frame = labelFrame;

        CGRectMake(20, 20, 20, 30);

        NSLog(@"label frame %@", NSStringFromCGRect(labelFrame));

        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:30]];
        cell.textLabel.textColor = [UIColor colorWithRed:0.22 green:0.3 blue:0.44 alpha:1];

        cell.textLabel.text = self.disabilities [indexPath.row];
        NSLog(@"Text label %@", self.disabilities [indexPath.row]);
    }

    if ([[self.switchStates objectAtIndex:indexPath.row] isEqualToString:@"ON"]) {
        theSwitch.on = YES;
    } else {
        theSwitch.on = NO;
    }

    if ([self.disabilities [indexPath.row] isEqualToString:@"A.D.D"]) {
        self.ADD = 1;
        [theSwitch addTarget:self action:@selector(onADDSwitch:) forControlEvents:UIControlEventValueChanged];
        NSLog(@"Switch is on %@", self.disabilities [indexPath.row]);
    } else if ([self.disabilities [indexPath.row] isEqualToString:@"A.D.H.D"]){
        self.ADHD = 1;
        [theSwitch addTarget:self action:@selector(onADHDSwitch:) forControlEvents:UIControlEventValueChanged];
        NSLog(@"Switch is on %@", self.disabilities [indexPath.row]);

    } else if ([self.disabilities [indexPath.row] isEqualToString:@"Dyslexia"]){
        self.Dys = 0;
        [theSwitch addTarget:self action:@selector(onDyslexiaSwitch:) forControlEvents:UIControlEventValueChanged];
        NSLog(@"Switch is on %@", self.disabilities [indexPath.row]);
    }


    return cell;
}

-(void)switchChanged:(UISwitch *)sender{
    UITableViewCell *cell = [[sender superview] superview];
    NSIndexPath *indexPathOfSwitch = [self.disabilitiesTableView indexPathForCell:cell];

    if (sender.on) {
        [self.switchStates replaceObjectAtIndex:indexPathOfSwitch.row withObject:@"ON"];
        sender.onTintColor = [UIColor colorWithRed:0.22 green:0.3 blue:0.44 alpha:1];
    } else {
        [self.switchStates replaceObjectAtIndex:indexPathOfSwitch.row withObject:@"OFF"];
    }
}

-(void)storeData{
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    [currentSettings setInteger:self.ADD forKey:@"CurrentADD"];
    [currentSettings setInteger:self.Dys forKey:@"CurrentDys"];
    [currentSettings setInteger:self.ADHD forKey:@"CurrentADHD"];

    if (self.ADD == 1) {
        [currentSettings setBool:self.switchADDSwitch.on forKey:@"CurrentADDSwitch"];
        NSLog(@"ADD Switch state on");
    } else {
        [currentSettings setBool:self.switchADDSwitch forKey:@"CurrentADDSwitch"];
        NSLog(@"ADD Switch state off");
    }

    if (self.ADHD == 1) {
        [currentSettings setBool:self.SwtchADHDSwitch.on forKey:@"CurrentADHDSwitch"];
        NSLog(@"ADHD Switch state on");
    } else {
        [currentSettings setBool:self.SwtchADHDSwitch forKey:@"CurrentADHDSwitch"];
        NSLog(@"ADHD Switch state off");
    }

    if (self.Dys == 1) {
        [currentSettings setBool:self.switchDyslexiaSwitch.on forKey:@"CurrentDYSSwitch"];
        NSLog(@"Dys Switch state on");
    } else {
        [currentSettings setBool:self.switchDyslexiaSwitch forKey:@"CurrentDYSSwitch"];
        NSLog(@"Dys Switch state off");
    }

    [currentSettings synchronize];

    NSLog(@"\nStoring UI2VC Current Age %ld, Gender %ld, ADHD %ld, ADD %ld, Dys %ld, StudyInt %ld, BreakInt %ld, Study %ld ,Break %ld",(long)self.age,(long)self.gender,(long)self.ADHD,(long)self.ADD,(long)self.Dys,(long)self.studySliderInt,(long)self.breakSliderInt,(long)self.studyTime,(long)self.breakTime);

}

-(void)getData{
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];

    NSInteger newAge = [currentSettings integerForKey:@"CurrentAge"];
    NSInteger newGender = [currentSettings integerForKey:@"CurrentGender"];
    NSInteger newADHD = [currentSettings integerForKey:@"CurrentADHD"];
    NSInteger newADD = [currentSettings integerForKey:@"CurrentADD"];
    NSInteger newDys = [currentSettings integerForKey:@"CurrentDys"];

    NSInteger newStudy = [currentSettings integerForKey:@"CurrentStudyTime"];
    NSInteger newBreak = [currentSettings integerForKey:@"CurrentBreakTime"];

    self.age = newAge;
    self.gender = newGender;
    self.ADHD = newADHD;
    self.ADD = newADD;
    self.Dys = newDys;

    self.studySliderInt = newStudy;
    self.breakSliderInt = newBreak;

    self.studyTime = self.studySliderInt;
    self.breakTime = self.breakSliderInt;

    NSLog(@"\nGetting UI2VC Current Age %ld, Gender %ld, ADHD %ld, ADD %ld, Dys %ld, StudyInt %ld, BreakInt %ld, Study %ld ,Break %ld",(long)self.age,(long)self.gender,(long)self.ADHD,(long)self.ADD,(long)self.Dys,(long)self.studySliderInt,(long)self.breakSliderInt,(long)self.studyTime,(long)self.breakTime);
}
@end
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
    self.disabilities = [[NSMutableArray alloc] initWithObjects:@"A.D.D",@"A.D.H.D",@"Dyslexia", nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableView:cellForRowAtIndexPath:) name:@"switchUpdate" object:nil];
//
}

-(void)updateSwitches:(UISwitch *)sender{
    [self getData];

    self.ADD = 0;
    self.ADHD = 0;
    self.Dys = 0;

    UITableView *tableView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCellID"];
    NSIndexPath *indexPathOfSwitch = [self.disabilitiesTableView indexPathForCell:cell];


    if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"A.D.D"]) {
        [sender setOn:NO animated:YES];
    }

    if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"A.D.H.D"]) {
        [sender setOn:NO animated:YES];
    }

    if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"Dyslexia"]) {
        [sender setOn:NO animated:YES];
    }

    [self storeData];
}

- (IBAction)onADDSwitch:(UISwitch *)sender {
    NSLog(@"onADDSwitch:");

    UITableView *tableView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCellID"];
    NSIndexPath *indexPathOfSwitch = [self.disabilitiesTableView indexPathForCell:cell];

    if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"A.D.D"]) {

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
            [sender setOn:NO animated:YES];
            [self.disabilities [indexPathOfSwitch.row] isEqualToString:@"A.D.D"];
            NSLog(@"ADD that switch %@ ", sender);
            self.ADD = 0;
        }

        if (self.ADD == 1) {
            [sender setOn:YES animated:YES];
        }
        NSLog(@"ADD Switch is on %ld", (long)self.ADD);
    } else {
        [sender setOn:NO animated:YES];
        self.ADD = 0;
        NSLog(@"ADD Switch is off %ld", (long)self.ADD);
    }
    [self storeData];
}

- (IBAction)onADHDSwitch:(UISwitch *)sender {
    NSLog(@"onADHDSwitch:");

    UITableView *tableView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCellID"];
    NSIndexPath *indexPathOfSwitch = [self.disabilitiesTableView indexPathForCell:cell];

    if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"A.D.H.D"]) {

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
            [sender setOn:NO animated:YES];
            [self.disabilities [indexPathOfSwitch.row] isEqualToString:@"A.D.H.D"];
            NSLog(@"A.D.H.D that switch %@ ", sender);
            self.ADHD = 0;
        }

        if (self.ADHD == 1) {
            [sender setOn:YES animated:YES];
        }
        NSLog(@"A.D.H.D Switch is on %ld", (long)self.ADHD);
    } else {
        [sender setOn:NO animated:YES];
        self.ADHD = 0;
        NSLog(@"A.D.H.D Switch is off %ld", (long)self.ADHD);
    }
    [self storeData];
}

- (IBAction)onDyslexiaSwitch:(UISwitch *)sender {
    NSLog(@"onDysSwitch:");

    UITableView *tableView;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCellID"];
    NSIndexPath *indexPathOfSwitch = [self.disabilitiesTableView indexPathForCell:cell];

    if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"Dyslexia"]) {

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
            [sender setOn:NO animated:YES];
            [self.disabilities [indexPathOfSwitch.row] isEqualToString:@"Dyslexia"];
            NSLog(@"Dyslexia that switch %@ ", sender);
            self.Dys = 0;
        }

        if (self.Dys == 1) {
            [sender setOn:YES animated:YES];
        }
        NSLog(@"Dyslexia Switch is on %ld", (long)self.Dys);
    } else {
        [sender setOn:NO animated:YES];
        self.Dys = 0;
        NSLog(@"Dyslexia Switch is off %ld", (long)self.Dys);
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

    [self getData];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCellID"];
        theSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        theSwitch.tag = 100;
        [theSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:theSwitch];

        CGRect switchFrame = theSwitch.frame;
        switchFrame.origin.x = 290;
        switchFrame.origin.y = 20;
        theSwitch.frame = switchFrame;

        CGRect labelFrame = cell.frame;
        labelFrame.origin.x = -123;
        labelFrame.origin.y = 0;
        cell.frame = labelFrame;

        CGRectMake(20, 20, 20, 30);

        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica Light" size:25]];
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
        if (self.ADD == 0) {
            theSwitch.on = NO;
        } else {
            self.ADD = 1;
            theSwitch.onTintColor = [UIColor colorWithRed:0.22 green:0.3 blue:0.44 alpha:1];
            theSwitch.on = YES;
        }
    }

    if ([self.disabilities [indexPath.row] isEqualToString:@"A.D.H.D"]){
        if (self.ADHD == 0) {
            theSwitch.on = NO;
        } else {
            self.ADHD = 1;
            theSwitch.onTintColor = [UIColor colorWithRed:0.22 green:0.3 blue:0.44 alpha:1];
            theSwitch.on = YES;
        }
    }

    if ([self.disabilities [indexPath.row] isEqualToString:@"Dyslexia"]){
        if (self.Dys == 0) {
            theSwitch.on = NO;
        } else {
            self.Dys = 1;
            theSwitch.onTintColor = [UIColor colorWithRed:0.22 green:0.3 blue:0.44 alpha:1];
            theSwitch.on = YES;
        }
    }

    return cell;
}

-(void)switchChanged:(UISwitch *)sender{
    NSLog(@"SwitchCahnged:");

    UITableViewCell *cell = sender.superview.superview;
    NSIndexPath *indexPathOfSwitch = [self.disabilitiesTableView indexPathForCell:cell];
    sender.onTintColor = [UIColor colorWithRed:0.22 green:0.3 blue:0.44 alpha:1];

    if (sender.on == YES) {
        [self.switchStates replaceObjectAtIndex:indexPathOfSwitch.row withObject:@"ON"];
        if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"A.D.D"]) {
            self.ADD = 1;
            [self storeData];
            [self onADDSwitch:sender];
        }

        if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"A.D.H.D"]){
            self.ADHD = 1;
            [self storeData];
            [self onADHDSwitch:sender];
        }

        if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"Dyslexia"]){
            self.Dys = 1;
            [self storeData];
            [self onDyslexiaSwitch:sender];
        }
    } else if (sender.on == NO){
        [self.switchStates replaceObjectAtIndex:indexPathOfSwitch.row withObject:@"OFF"];
        if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"A.D.D"]) {
            self.ADD = 0;
            [self storeData];
            [sender addTarget:self action:@selector(onADDSwitch:) forControlEvents:UIControlEventValueChanged];
        }

        if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"A.D.H.D"]){
            self.ADHD = 0;
            [self storeData];
            [sender addTarget:self action:@selector(onADHDSwitch:) forControlEvents:UIControlEventValueChanged];
        }

        if ([self.disabilities [indexPathOfSwitch.row] isEqualToString:@"Dyslexia"]){
            self.Dys = 0;
            [self storeData];
            [sender addTarget:self action:@selector(onDyslexiaSwitch:) forControlEvents:UIControlEventValueChanged];
        }
    }
}

-(void)storeData{
    NSLog(@"Store Data:");
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    [currentSettings setInteger:self.ADD forKey:@"CurrentADD"];
    [currentSettings setInteger:self.Dys forKey:@"CurrentDys"];
    [currentSettings setInteger:self.ADHD forKey:@"CurrentADHD"];

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
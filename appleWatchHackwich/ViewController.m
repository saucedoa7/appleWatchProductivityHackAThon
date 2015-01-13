//
//  ViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.detailsView.hidden = YES;

    NSLog(@"VIEW DID LOAD!!!!!");
}

-(IBAction)unWindToMainVC:(UIStoryboardSegue *)sender{

    self.detailsView.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [self GetData];

    if (self.age != 0 || self.gender != 0) {

        self.studyTime = 0;
        self.breakTime = 0;
    } else {

        self.age = 0;
        self.gender = 0;
        self.ADHD = 0;
        self.ADD = 0;
        self.dys = 0;
        self.studyTime = self.studySliderInt;
        self.breakTime = self.breakSliderInt;
    }

    if (self.studySliderInt == 0 && self.breakSliderInt == 0) {
        self.studyTime = 20;
        self.breakTime = 5;
        NSLog(@"Current Age %ld", (long)self.age);
    }

    if (self.age >= 1 && self.age <= 12) {
        self.studyTime = self.studyTime + 1;
        self.breakTime = self.breakTime + 10;
        NSLog(@"12 Productivity TIme %.2f minutes", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if (self.age >= 13 && self.age <= 24) {
        self.studyTime = self.studyTime + 2;
        self.breakTime = self.breakTime + 10;
        NSLog(@"13 - 24 Productivity TIme %.2f minutes", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if (self.age >= 25 && self.age <= 30) {
        self.studyTime = self.studyTime + 3;
        self.breakTime = self.breakTime + 10;
        NSLog(@"25 - 30 Productivity TIme %.2f minutes", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if (self.age >= 31 && self.age <= 100) {
        self.studyTime = self.studyTime + 4;
        self.breakTime = self.breakTime + 10;
        NSLog(@"31 - 100 Productivity TIme %.2f minutes", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    }

    if (self.gender == 1) {
        self.studyTime = self.studyTime + 0;
        NSLog(@"Male Productivity TIme %.2f minutes", self.studyTime);
    } else if (self.gender == 2){
        self.studyTime = self.studyTime + 5;
        NSLog(@"Female Productivity TIme %.2f minutes", self.studyTime);
    }

    if (self.ADHD == 0) {
        self.studyTime = self.studyTime + 0;
        NSLog(@"w/o ADHD Productivity TIme %.2f minutes", self.studyTime);
    } else {
        self.studyTime = self.studyTime + 6;
        NSLog(@"W/ ADHD Productivity TIme %.2f minutes", self.studyTime);
    }

    NSLog(@"ADD before IF STATEMENT %ld", (long)self.ADD);
    if (self.ADD == 0) {
        self.studyTime = self.studyTime + 0;
        NSLog(@"w/o ADD Productivity TIme %.2f minutes", self.studyTime);
    } else {
        self.studyTime = self.studyTime + 7;
        NSLog(@"w/ AdDD Productivity TIme %.2f minutes", self.studyTime);
    }

    NSLog(@"DYS before IF STATEMENT %ld", (long)self.Dys);

    if (self.Dys == 0) {
        self.studyTime = self.studyTime + 0;
        NSLog(@"w/o DYS Productivity TIme %.2f minutes", self.studyTime);
    } else {
        self.studyTime = self.studyTime + 8;
        NSLog(@"w/ DYS Productivity TIme %.2f minutes", self.studyTime);
    }

    self.lblStudy.text = [NSString stringWithFormat:@"%ld", (long)self.studyTime];
    self.lblBreak.text = [NSString stringWithFormat:@"%ld", (long)self.breakTime];

    NSLog(@"lblStudy Time %@", self.lblStudy.text);
    NSLog(@"lblBreak Time %@", self.lblBreak.text);

    [self storeData];
}

-(void)GetData{

#pragma mark Get Data from other VC's
    // NSUserDefaults *testSettings = [NSUserDefaults standardUserDefaults];

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

    NSLog(@"Getting data to VC Current age %ld /n", (long)self.age);
    NSLog(@"Getting data to VC Current gender %ld", (long)self.gender);
    NSLog(@"Getting data to VC Current ADHD %ld", (long)self.ADHD);
    NSLog(@"Getting data to VC Current ADD %ld", (long)self.ADD);
    NSLog(@"Getting data to VC Current Dys %ld", (long)self.Dys);

    NSLog(@"Getting data to VC Current Study Time %ld", (long)self.studyTime);
    NSLog(@"Getting data to VC Current Break Time %ld", (long)self.breakTime);
}

-(void)storeData{

#pragma mark Pass Data To VC
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];

    [currentSettings setInteger:self.studyTime forKey:@"CurrentStudyTime"];
    [currentSettings setInteger:self.breakTime forKey:@"CurrentBreakTime"];

    [currentSettings synchronize];

    NSLog(@"Store Data For Interface Current Study %ld", (long)self.studyTime);
    NSLog(@"Store Data For Interface Current Break %ld", (long)self.breakTime);
}
@end
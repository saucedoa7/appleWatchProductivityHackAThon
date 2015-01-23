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
    if (self.studyTime == 0) {
        self.detailsView.hidden = YES;
    }

    NSLog(@"VIEW DID LOAD!!!!!");
    [self GetData];
    [self storeData];

}

-(IBAction)unWindToMainVCDone:(UIStoryboardSegue *)sender{

    if (self.studyTime == 0) {
        self.detailsView.hidden = YES;
    }
    //self.detailsView.hidden = NO;
}

-(IBAction)unWindToMainVCCancel:(UIStoryboardSegue *)sender{

    if (self.studyTime == 0) {
        self.detailsView.hidden = YES;
    }
    //self.detailsView.hidden = NO;

}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"VC View Will Disappear");
    [self GetData];
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"VC View will appear");
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
        self.studyTime = 0;
        self.breakTime = 0;
        NSLog(@"Current Age %ld", (long)self.age);
    }

    if (self.age >= 1 && self.age <= 12) {
        self.studyTime = self.studyTime + 1;
        self.breakTime = self.breakTime + 1;
        NSLog(@"12 Productivity TIme %.2f minutes +1", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if (self.age >= 13 && self.age <= 24) {
        self.studyTime = self.studyTime + 2;
        self.breakTime = self.breakTime + 2;
        NSLog(@"13 - 24 Productivity TIme %.2f minutes +2", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if (self.age >= 25 && self.age <= 30) {
        self.studyTime = self.studyTime + 3;
        self.breakTime = self.breakTime + 3;
        NSLog(@"25 - 30 Productivity TIme %.2f minutes +3", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if (self.age >= 31 && self.age <= 100) {
        self.studyTime = self.studyTime + 4;
        self.breakTime = self.breakTime + 4;
        NSLog(@"31 - 100 Productivity TIme %.2f minutes +4", self.studyTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    }

    if (self.gender == 1) {
        self.studyTime = self.studyTime + 0;
        NSLog(@"Male Productivity TIme %.2f minutes +0", self.studyTime);
    } else if (self.gender == 2){
        self.studyTime = self.studyTime + 5;
        NSLog(@"Female Productivity TIme %.2f minutes +5", self.studyTime);
    }

    if (self.ADHD == 0) {
        self.studyTime = self.studyTime + 0;
        NSLog(@"w/o ADHD Productivity TIme %.2f minutes +0", self.studyTime);
    } else {
        self.studyTime = self.studyTime + 6;
        NSLog(@"W/ ADHD Productivity TIme %.2f minutes +6", self.studyTime);
    }

    NSLog(@"ADD before IF STATEMENT %ld", (long)self.ADD);
    if (self.ADD == 0) {
        self.studyTime = self.studyTime + 0;
        NSLog(@"w/o ADD Productivity TIme %.2f minutes +0", self.studyTime);
    } else {
        self.studyTime = self.studyTime + 7;
        NSLog(@"w/ AdDD Productivity TIme %.2f minutes +7", self.studyTime);
    }

    NSLog(@"DYS before IF STATEMENT %ld", (long)self.Dys);

    if (self.Dys == 0) {
        self.studyTime = self.studyTime + 0;
        NSLog(@"w/o DYS Productivity TIme %.2f minutes +0", self.studyTime);
    } else {
        self.studyTime = self.studyTime + 8;
        NSLog(@"w/ DYS Productivity TIme %.2f minutes +8", self.studyTime);
    }

    self.lblStudy.text = [NSString stringWithFormat:@"%ld", (long)self.studyTime];
    self.lblBreak.text = [NSString stringWithFormat:@"%ld", (long)self.breakTime];

    NSLog(@"lblStudy Time %@", self.lblStudy.text);
    NSLog(@"lblBreak Time %@", self.lblBreak.text);

    if (self.age > 0) {
        self.studySliderInt = 0;
        self.breakSliderInt = 0;
    }

    if (self.studyTime == 0) {
        self.detailsView.hidden = YES;
    } else {
        self.detailsView.hidden = NO;
    }

    [self storeData];
}

-(void)GetData{

#pragma mark Get Data from other VC's

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

    NSLog(@"\nGetting data to VC Current Age %ld, Gender %ld, ADHD %ld, ADD %ld, Dys %ld, StudyInt %ld, BreakInt %ld, Study %ld ,Break %ld",(long)self.age,(long)self.gender,(long)self.ADHD,(long)self.ADD,(long)self.Dys,(long)self.studySliderInt,(long)self.breakSliderInt,(long)self.studyTime,(long)self.breakTime);
}

-(void)storeData{

#pragma mark Pass Data To VC
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];

    [currentSettings setInteger:self.age forKey:@"CurrentAge"];
    [currentSettings setInteger:self.gender forKey:@"CurrentGender"];
    [currentSettings setInteger:self.ADHD forKey:@"CurrentADHD"];
    [currentSettings setInteger:self.ADD forKey:@"CurrentADD"];
    [currentSettings setInteger:self.Dys forKey:@"CurrentDys"];

    [currentSettings setInteger:self.studyTime forKey:@"CurrentStudyTime"];
    [currentSettings setInteger:self.breakTime forKey:@"CurrentBreakTime"];

    [currentSettings setInteger:self.studySliderInt forKey:@"CurrentStudyInt"];
    [currentSettings setInteger:self.breakSliderInt forKey:@"CurrentBreakInt"];

    [currentSettings synchronize];

    NSLog(@"\nStore Data For Interface Current Age %ld, Gender %ld, ADHD %ld, ADD %ld, Dys %ld, StudyInt %ld, BreakInt %ld, Study %ld ,Break %ld",(long)self.age,(long)self.gender,(long)self.ADHD,(long)self.ADD,(long)self.Dys,(long)self.studySliderInt,(long)self.breakSliderInt,(long)self.studyTime,(long)self.breakTime);
}
@end
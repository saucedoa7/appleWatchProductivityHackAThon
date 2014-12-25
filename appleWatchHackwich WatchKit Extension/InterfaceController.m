//
//  InterfaceController.m
//  appleWatchHackwich WatchKit Extension
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

//Yes


#import "InterfaceController.h"
#import "UserInfoOneViewController.h"

@interface InterfaceController()
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnStartStop;
@property (strong, nonatomic) IBOutlet WKInterfaceTimer *lblTimer;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnPause;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnRestart;
@property (strong, nonatomic) IBOutlet WKInterfaceTimer *tmrCountdown;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *lblTest;

@property NSTimeInterval studyTime;
@property NSTimeInterval breakTime;
@property NSTimeInterval hideStartTime;

@property (nonatomic)  NSTimer *studyTimerHasFinished;
@property (nonatomic)  NSTimer *breakTimerHasFinished;

@property NSDate *initialDate;
@property NSDate *hideDate;

@property BOOL isRestarting;
@property BOOL isPaused;

@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;
@property NSInteger studySliderInt;
@property NSInteger breakSliderInt;


@end

@implementation InterfaceController


- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        NSLog(@"%@ initWithContext", self);
        //self.isRestarting = false;
        self.isPaused = false;
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

- (IBAction)onStartStopTimer {
    [self.btnStartStop setEnabled:YES];

    [self startTImer];
}

- (void)startTImer {

    NSLog(@"isRestarting %d", self.isRestarting);
    [self.btnStartStop setEnabled:NO];

    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    NSInteger newAge = [currentSettings integerForKey:@"CurrentAge"];
    NSInteger newGender = [currentSettings integerForKey:@"CurrentGender"];
    NSInteger newADHD = [currentSettings integerForKey:@"CurrentADHD"];
    NSInteger newStudy = [currentSettings integerForKey:@"CurrentStudyInt"];
    NSInteger newBreak = [currentSettings integerForKey:@"CurrentBreakInt"];

    self.age = newAge;
    self.gender = newGender;
    self.ADHD = newADHD;
    self.studySliderInt = newStudy;
    self.breakSliderInt = newBreak;

    NSLog(@"1 Current Age %ld", (long)self.age);
    NSLog(@"1 Current Gender %ld", (long)self.gender);
    NSLog(@"1 Current ADHD %ld", (long)self.ADHD);
    NSLog(@"1 Current Study %ld", (long)self.studySliderInt);
    NSLog(@"1 Current Break %ld", (long)self.breakSliderInt);

    if (self.studySliderInt == 0 && self.breakSliderInt == 0) {
        self.studyTime = 20;
        self.breakTime = 5;
        NSLog(@"Current Age %ld", (long)self.age);

        if (self.age < 12) {
            self.studyTime = self.studyTime + 100;
            self.breakTime = self.breakTime + 0;
            NSLog(@"12 Productivity TIme %.2f minutes", self.studyTime);
            NSLog(@"Break TIme %.2f minutes", self.breakTime);
        } else if (self.age >= 13 && self.age <= 24) {
            self.studyTime = self.studyTime + 90;
            self.breakTime = self.breakTime + 5;
            NSLog(@"13 - 24 Productivity TIme %.2f minutes", self.studyTime);
            NSLog(@"Break TIme %.2f minutes", self.breakTime);
        } else if (self.age >= 25 && self.age <= 30) {
            self.studyTime = self.studyTime + 80;
            self.breakTime = self.breakTime + 10;
            NSLog(@"25 - 30 Productivity TIme %.2f minutes", self.studyTime);
            NSLog(@"Break TIme %.2f minutes", self.breakTime);
        } else if (self.age >= 31 && self.age <= 100) {
            self.studyTime = self.studyTime + 70;
            self.breakTime = self.breakTime + 20;
            NSLog(@"31 - 35 Productivity TIme %.2f minutes", self.studyTime);
            NSLog(@"Break TIme %.2f minutes", self.breakTime);
        }

        if (self.gender == 0) {
            self.studyTime = self.studyTime + 6;
            NSLog(@"Male Productivity TIme %.2f minutes", self.studyTime);
        } else {
            self.studyTime = self.studyTime + 9;
            NSLog(@"Female Productivity TIme %.2f minutes", self.studyTime);
        }

        if (self.ADHD == 0) {
            self.studyTime = self.studyTime + 0;
            NSLog(@"w/o ADHD Productivity TIme %.2f minutes", self.studyTime);
        } else {
            self.studyTime = self.studyTime + 15;
            NSLog(@"W/ ADHD Productivity TIme %.2f minutes", self.studyTime);
        }
    } else {

        self.studyTime = self.studySliderInt;
        self.breakTime = self.breakSliderInt;
    }

    NSLog(@"Current Study Time %.0f \n", self.studyTime);

    if (self.isRestarting == false) {
        self.studyTime = self.studyTime * .25;
        self.initialDate = [[NSDate alloc] initWithTimeIntervalSinceNow:self.studyTime];
        [self.lblTimer setDate:self.initialDate];
        [self.btnStartStop setColor:[UIColor colorWithHue:0.98 saturation:1 brightness:0.89 alpha:0]];
        [self.btnStartStop setTitle:@"Study Time!"];
    }

    else if (self.isRestarting == true) {
        self.breakTime = self.breakTime * 1;
        self.initialDate = [[NSDate alloc] initWithTimeIntervalSinceNow:self.breakTime];
        [self.lblTimer setDate:self.initialDate];
        [self.btnStartStop setColor:[UIColor colorWithHue:0.98 saturation:1 brightness:0.89 alpha:0]];
        [self.btnStartStop setTitle:@"Break time!!"];
    }

  /*      self.hideStartTime = 3;
        self.hideDate = [[NSDate alloc] initWithTimeIntervalSinceNow:self.hideStartTime];
        [self.lblTimer setDate:self.hideDate];
    
        NSLog(@"%@", self.hideDate);
    
        if (self.hideDate == 0) {
            self.lblTest.accessibilityElementsHidden = NO;
        }*/

    [self.lblTimer start];
    [self.lblTimer setDate:self.initialDate];
    if (self.isRestarting == false) {

    self.studyTimerHasFinished = [NSTimer scheduledTimerWithTimeInterval:self.studyTime
                                                                  target:self
                                                                selector:@selector(doneStudying:)
                                                                userInfo:nil
                                                                 repeats:NO];
    }

    else if (self.isRestarting == true) {

    self.breakTimerHasFinished = [NSTimer scheduledTimerWithTimeInterval:self.breakTime
                                                                  target:self
                                                                selector:@selector(doneBreak:)
                                                                userInfo:nil
                                                                 repeats:NO];
    }
}

-(void)doneStudying:(NSTimer *)timer{
    [self.btnStartStop setEnabled:YES];

        [self.btnStartStop setColor:[UIColor colorWithHue:0.98 saturation:1 brightness:0.89 alpha:1]];
        [self.btnStartStop setTitle:@"Take a Break!"];
        self.isRestarting = true;
}

-(void)doneBreak:(NSTimer *)timer{
    [self.btnStartStop setEnabled:YES];


        [self.btnStartStop setColor:[UIColor colorWithHue:0.98 saturation:1 brightness:0.89 alpha:1]];
        [self.btnStartStop setTitle:@"Back to Study!"];
        self.isRestarting = false;
}

- (IBAction)onPause{
    if (self.isPaused == false) {
        [self.lblTimer stop];
        //[self.studyTimerHasFinished invalidate];
        self.studyTimerHasFinished = nil;
        NSLog(@"NSTImer Stopped at %@", self.studyTimerHasFinished);
        [self.btnPause setTitle:@"Resume"];
        self.isPaused = true;
    } else if (self.isPaused == true){
        [self.lblTimer start];
        self.studyTimerHasFinished = nil;

        [self.btnPause setTitle:@"Pause"];
        self.isPaused = false;
    }
}

- (IBAction)onRestart {
    [self startTImer];
}
@end
//
//  InterfaceController.m
//  appleWatchHackwich WatchKit Extension
//
//  Created by Albert Saucedo on 12/6/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "InterfaceController.h"
#import "UserInfoViewController.h"

@interface InterfaceController()
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnStartStop;
@property (strong, nonatomic) IBOutlet WKInterfaceTimer *lblTimer;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnPause;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *btnRestart;

@property NSTimeInterval productivityTime;
@property NSTimeInterval breakTime;
@property (nonatomic)  NSTimer *timerHasFinished;
@property NSDate *initialDate;
@property BOOL isRest;
@property BOOL isPaused;


@end

@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        NSLog(@"%@ initWithContext", self);
        self.isRest = false;
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
    [self.btnStartStop setEnabled:NO];

    [self startTImer];
}

- (void)startTImer {
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    NSInteger newAge = [currentSettings integerForKey:@"CurrentAge"];
    NSInteger newGender = [currentSettings integerForKey:@"CurrentGender"];
    NSInteger newADHD = [currentSettings integerForKey:@"CurrentADHD"];

    self.age = newAge;
    self.gender = newGender;
    self.ADHD = newADHD;

    NSLog(@"1 Current Age %ld", (long)self.age);
    NSLog(@"1 Current Gender %ld", (long)self.gender);
    NSLog(@"1 Current ADHD %ld", (long)self.ADHD);

    self.productivityTime = 20;
    self.breakTime = 5;

    if (self.age < 12) {
        self.productivityTime = self.productivityTime + 100;
        self.breakTime = self.breakTime + 0;
        NSLog(@"Productivity TIme %.2f minutes", self.productivityTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if ((self.age > 12) && (self.age < 24)) {
        self.productivityTime = self.productivityTime + 90;
        self.breakTime = self.breakTime + 5;
        NSLog(@"Productivity TIme %.2f minutes", self.productivityTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if ((self.age > 25) && (self.age < 30)) {
        self.productivityTime = self.productivityTime + 80;
        self.breakTime = self.breakTime + 10;
        NSLog(@"Productivity TIme %.2f minutes", self.productivityTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    } else if ((self.age > 31) && (self.age < 35)) {
        self.productivityTime = self.productivityTime + 70;
        self.breakTime = self.breakTime + 20;
        NSLog(@"Productivity TIme %.2f minutes", self.productivityTime);
        NSLog(@"Break TIme %.2f minutes", self.breakTime);
    }

    self.gender  = 0;
    if (self.gender == 0) {
        self.productivityTime = self.productivityTime + 6;
        NSLog(@"Productivity TIme %.2f minutes", self.productivityTime);
    } else {
        self.productivityTime = self.productivityTime + 9;
        NSLog(@"Productivity TIme %.2f minutes", self.productivityTime);
    }

    self.ADHD = 0;
    if (self.ADHD == 0) {
        self.productivityTime = self.productivityTime + 6;
        NSLog(@"Productivity TIme %.2f minutes", self.productivityTime);
    } else {
        self.productivityTime = self.productivityTime + 9;
        NSLog(@"Productivity TIme %.2f minutes", self.productivityTime);
    }

    if (self.isRest == false) {
        self.productivityTime = self.productivityTime * 0.1;
        self.initialDate = [[NSDate alloc] initWithTimeIntervalSinceNow:self.productivityTime];
        [self.lblTimer setDate:self.initialDate];
        [self.btnStartStop setColor:[UIColor colorWithRed:0.29 green:0.4 blue:0.62 alpha:1]];
        [self.btnStartStop setTitle:@"Werk Time!"];
    } else if (self.isRest == true) {
        self.breakTime = self.breakTime * 60;
        self.initialDate = [[NSDate alloc] initWithTimeIntervalSinceNow:self.breakTime];
        [self.lblTimer setDate:self.initialDate];
        [self.btnStartStop setColor:[UIColor colorWithRed:0.29 green:0.4 blue:0.62 alpha:1]];
        [self.btnStartStop setTitle:@"Break time!!"];
    }

    [self.lblTimer setDate:self.initialDate];
    [self.lblTimer start];

    self.timerHasFinished = [NSTimer scheduledTimerWithTimeInterval:self.productivityTime
                                                             target:self
                                                           selector:@selector(doneWorking:)
                                                           userInfo:nil
                                                            repeats:false];
}

-(void)doneWorking:(NSTimer *)timer{
    [self.btnStartStop setEnabled:YES];
    if (self.isRest == false) {
        [self.btnStartStop setColor:[UIColor colorWithRed:0.19 green:0.22 blue:0.36 alpha:1]];
        [self.btnStartStop setTitle:@"Take a Break!"];
        self.isRest = true;
    } else if (self.isRest == true) {
        [self.btnStartStop setColor:[UIColor colorWithRed:0.82 green:0.89 blue:0.95 alpha:1]];
        [self.btnStartStop setTitle:@"Back to werk!"];
        self.isRest = false;
    }
}

- (IBAction)onPause{
    if (self.isPaused == false) {
        [self.lblTimer stop];
        [self.btnPause setTitle:@"Resume"];
        self.isPaused = true;
    } else if (self.isPaused == true){
        [self.lblTimer start];
        [self.btnPause setTitle:@"Pause"];
        self.isPaused = false;
    }
}
- (IBAction)onRestart {
    [self startTImer];
}
@end
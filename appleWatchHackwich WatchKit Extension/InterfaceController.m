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
    NSInteger newStudyTime = [currentSettings integerForKey:@"CurrentStudyTime"];
    NSInteger newBreakTime = [currentSettings integerForKey:@"CurrentBreakTime"];
    self.studyTime = newStudyTime;
    self.breakTime = newBreakTime;

    NSLog(@"Current Study Time %.0f \n", self.studyTime);

    if (self.isRestarting == false) {
        self.studyTime = self.studyTime * 60;
        self.initialDate = [[NSDate alloc] initWithTimeIntervalSinceNow:self.studyTime];
        [self.lblTimer setDate:self.initialDate];
        [self.btnStartStop setColor:[UIColor colorWithHue:0.98 saturation:1 brightness:0.89 alpha:0]];
        [self.btnStartStop setTitle:@"Study Time!"];
    }

    else if (self.isRestarting == true) {
        self.breakTime = self.breakTime * 60;
        self.initialDate = [[NSDate alloc] initWithTimeIntervalSinceNow:self.breakTime];
        [self.lblTimer setDate:self.initialDate];
        [self.btnStartStop setColor:[UIColor colorWithHue:0.98 saturation:1 brightness:0.89 alpha:0]];
        [self.btnStartStop setTitle:@"Break time!!"];
    }

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
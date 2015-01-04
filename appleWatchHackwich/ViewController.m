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
}

-(IBAction)unWindToMainVC:(UIStoryboardSegue *)sender{
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    NSInteger newStudy = [currentSettings integerForKey:@"CurrentStudyInt"];
    NSInteger newBreak = [currentSettings integerForKey:@"CurrentBreakInt"];

    self.studySliderInt = newStudy;
    self.breakSliderInt = newBreak;

    NSLog(@"2 Current Study %ld", (long)self.studySliderInt);
    NSLog(@"2 Current Break %ld", (long)self.breakSliderInt);

    self.detailsView.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    self.lblStudy.text = [NSString stringWithFormat:@"%ld", (long)self.studySliderInt];
    self.lblBreak.text = [NSString stringWithFormat:@"%ld", (long)self.breakSliderInt];
}
@end

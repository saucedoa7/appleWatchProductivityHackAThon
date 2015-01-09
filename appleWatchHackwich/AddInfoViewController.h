//
//  AddInfoViewController.h
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISlider *sldStudySlider;
@property (strong, nonatomic) IBOutlet UISlider *sldBreakSlider;
@property (strong, nonatomic) IBOutlet UILabel *lblStudyTime;
@property (strong, nonatomic) IBOutlet UILabel *lblBreakTime;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray *pageOneLabels;
@property (strong, nonatomic) NSArray *pageTwoLabels;
@property (strong, nonatomic) NSArray *pageViews;

@property NSTimeInterval studyTime;
@property NSTimeInterval breakTime;

@property NSInteger studySliderInt;
@property NSInteger breakSliderInt;
@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;
@property NSInteger ADD;
@property NSInteger Dys;

@end

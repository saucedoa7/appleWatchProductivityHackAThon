//
//  AddInfoViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "AddInfoViewController.h"
#import "UserInfoOneViewController.h"
#import "UserInfoTwoViewController.h"

@interface AddInfoViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property NSInteger studySliderInt;
@property NSInteger breakSliderInt;
@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;

@end

@implementation AddInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.pageControl.hidden = YES;

    UserInfoOneViewController *pageOne = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    UserInfoTwoViewController *pageTwo = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PageContentTwoViewController"];

    self.pageViews = [[NSArray alloc] initWithObjects:pageOne,pageTwo, nil];

    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    [self.pageViewController setDelegate:self];
    [self.pageViewController setDataSource:self];

    NSArray *viewControllers = [NSArray arrayWithObject:[self.pageViews objectAtIndex:0]];
    [self.pageControl setCurrentPage:0];
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];

    NSLog(@"new arrayyyyy %@", viewControllers);

    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];

    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 230);

    [self addChildViewController:self.pageViewController];

    [self.view addSubview:self.pageControl];
    [[self view] addSubview:[self.pageViewController view]];
    [self.pageViewController didMoveToParentViewController:self];

    [self.view sendSubviewToBack:[self.pageViewController view]];

    self.studySliderInt = 0;
    self.breakSliderInt = 0;
}

#pragma mark UIPageController

- (void)changePage:(id)sender {

    UIViewController *visibleViewController = self.pageViewController.viewControllers[0];
    NSUInteger currentIndex = [self.pageViews indexOfObject:visibleViewController];

    NSArray *viewControllers = [NSArray arrayWithObject:[self.pageViews objectAtIndex:self.pageControl.currentPage]];

    if (self.pageControl.currentPage > currentIndex) {
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    } else {
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];

    }
}

#pragma mark - Page View Controller Data Source

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{

    // get the index of the current view controller on display
    NSUInteger currentIndex = [self.pageViews indexOfObject:viewController];
    // move the pageControl indicator to the next page
    [self.pageControl setCurrentPage:self.pageControl.currentPage-1];

    // check if we are at the beginning and decide if we need to present the previous viewcontroller
    if ( currentIndex > 0) {
        // return the previous viewcontroller
        return [self.pageViews objectAtIndex:currentIndex-1];
    } else {
        // do nothing
        return nil;
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    // get the index of the current view controller on display
    NSUInteger currentIndex = [self.pageViews indexOfObject:viewController];

    // move the pageControl indicator to the next page
    [self.pageControl setCurrentPage:self.pageControl.currentPage+1];

    // check if we are at the end and decide if we need to present the next viewcontroller
    if ( currentIndex < [self.pageViews count]-1) {
        // return the next view controller
        return [self.pageViews objectAtIndex:currentIndex+1];
    } else {
        // do nothing
        return nil;
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [self.pageViews count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

#pragma mark Sliders

- (IBAction)onStudySlide:(UISlider *)sender {
    UserInfoOneViewController *pageOne = [UserInfoOneViewController new];

    self.lblStudyTime.text =[[NSString alloc] initWithFormat:@"%.0fm", round(self.sldStudySlider.value)];
    self.studySliderInt = round(self.sldStudySlider.value);
    pageOne.txtAge.text = @"0";
    [pageOne.SwtchADHDSwitch setOn:NO animated:YES];
    [pageOne.pickGenderPicker selectRow:0 inComponent:0 animated:YES];
}

- (IBAction)onBreakTime:(UISlider *)sender {
    UserInfoOneViewController *pageOne =[UserInfoOneViewController new];

    self.lblBreakTime.text = [[NSString alloc] initWithFormat:@"%.0fm", round(self.sldBreakSlider.value)];
    self.breakSliderInt = round(self.sldBreakSlider.value) ;
    [pageOne.SwtchADHDSwitch setOn:NO animated:YES];
    [pageOne.pickGenderPicker selectRow:0 inComponent:0 animated:YES];
}

- (IBAction)onDoneButtonPressed:(UIButton *)sender {

    if (self.age != 0 || self.gender != 0) {
        self.studySliderInt = 0;
        self.breakSliderInt = 0;
    }

    if (self.age == 0 || self.gender == 0){
        self.age = 0;
        self.gender = 0;
        self.ADHD = 0;
        self.studySliderInt = self.sldStudySlider.value;
        self.breakSliderInt = self.sldBreakSlider.value;
    }

    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    [currentSettings setInteger:self.age forKey:@"CurrentAge"];
    [currentSettings setInteger:self.gender forKey:@"CurrentGender"];
    [currentSettings setInteger:self.ADHD forKey:@"CurrentADHD"];
    [currentSettings setInteger:self.studySliderInt forKey:@"CurrentStudyInt"];
    [currentSettings setInteger:self.breakSliderInt forKey:@"CurrentBreakInt"];
    [currentSettings synchronize];

    NSLog(@"0 Current Age %ld", (long)self.age);
    NSLog(@"0 Current Gender %ld", (long)self.gender);
    NSLog(@"0 Current ADHD %ld", (long)self.ADHD);
    NSLog(@"0 Current Study %ld", (long)self.studySliderInt);
    NSLog(@"0 Current Break %ld", (long)self.breakSliderInt);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}
@end

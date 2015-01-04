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

    //Get Data from UI1VC
    NSUserDefaults *settingFromUserInfoOneVC = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    NSInteger newADD = [settingFromUserInfoOneVC integerForKey:@"CurrentFromUserInfoOneVCADD"];
    NSInteger newDyslexia = [settingFromUserInfoOneVC integerForKey:@"CurrentFromUserInfoOneDys"];

    //Pass Data to IntVC & VC
    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    [currentSettings setInteger:self.age forKey:@"CurrentAge"];
    [currentSettings setInteger:self.gender forKey:@"CurrentGender"];
    [currentSettings setInteger:self.ADHD forKey:@"CurrentADHD"];
    [currentSettings setInteger:self.studySliderInt forKey:@"CurrentStudyInt"];
    [currentSettings setInteger:self.breakSliderInt forKey:@"CurrentBreakInt"];
    [currentSettings setInteger:self.ADD forKey:@"CurrentADD"];
    [currentSettings setInteger:self.dyslexia forKey:@"CurrentDyslexia"];
    [currentSettings setInteger:self.studyTime forKey:@"CurrentStudyTIme"];
    [currentSettings synchronize];

    NSLog(@"0 Current Age %ld", (long)self.age);
    NSLog(@"0 Current Gender %ld", (long)self.gender);
    NSLog(@"0 Current ADHD %ld", (long)self.ADHD);
    NSLog(@"0 Current Study %ld", (long)self.studySliderInt);
    NSLog(@"0 Current Break %ld", (long)self.breakSliderInt);
    NSLog(@"0 Current ADD %ld", (long)self.ADD);
    NSLog(@"0 Current Dys %ld", (long)self.dyslexia);

    NSInteger newAge = [currentSettings integerForKey:@"CurrentAge"];
    NSInteger newGender = [currentSettings integerForKey:@"CurrentGender"];
    NSInteger newADHD = [currentSettings integerForKey:@"CurrentADHD"];
    NSInteger newStudy = [currentSettings integerForKey:@"CurrentStudyInt"];
    NSInteger newBreak = [currentSettings integerForKey:@"CurrentBreakInt"];

    self.age = newAge;
    self.gender = newGender;
    self.ADHD = newADHD;
    self.ADD = newADD;
    self.dyslexia = newDyslexia;
    self.studySliderInt = newStudy;
    self.breakSliderInt = newBreak;

    if (self.studySliderInt == 0 && self.breakSliderInt == 0) {
        self.studyTime = 20;
        self.breakTime = 5;
        NSLog(@"Current Age %ld", (long)self.age);

        if (self.age < 12) {
            self.studyTime = self.studyTime + 15;
            self.breakTime = self.breakTime + 5;
            NSLog(@"12 Productivity TIme %.2f minutes", self.studyTime);
            NSLog(@"Break TIme %.2f minutes", self.breakTime);
        } else if (self.age >= 13 && self.age <= 24) {
            self.studyTime = self.studyTime + 90;
            self.breakTime = self.breakTime + 15;
            NSLog(@"13 - 24 Productivity TIme %.2f minutes", self.studyTime);
            NSLog(@"Break TIme %.2f minutes", self.breakTime);
        } else if (self.age >= 25 && self.age <= 30) {
            self.studyTime = self.studyTime + 50;
            self.breakTime = self.breakTime + 10;
            NSLog(@"25 - 30 Productivity TIme %.2f minutes", self.studyTime);
            NSLog(@"Break TIme %.2f minutes", self.breakTime);
        } else if (self.age >= 31 && self.age <= 100) {
            self.studyTime = self.studyTime + 30;
            self.breakTime = self.breakTime + 10;
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

        if (self.ADD == 0) {
            self.studyTime = self.studyTime + 0;
            NSLog(@"w/o ADD Productivity TIme %.2f minutes", self.studyTime);
        } else {
            self.studyTime = self.studyTime + 20;
            NSLog(@"w/ AdDD Productivity TIme %.2f minutes", self.studyTime);
        }

        if (self.dyslexia == 0) {
            self.studyTime = self.studyTime + 0;
            NSLog(@"w/o DYS Productivity TIme %.2f minutes", self.studyTime);
        } else {
            self.studyTime = self.studyTime + 10;
            NSLog(@"w/ DYS Productivity TIme %.2f minutes", self.studyTime);
        }

    } else {

        self.studyTime = self.studySliderInt;
        self.breakTime = self.breakSliderInt;
    }

    self.lblStudyTime.text = [NSString stringWithFormat:@"%.0f", self.studyTime];
    NSLog(@"Current Study Time %.0f \n", self.studyTime);


    if (self.age != 0 || self.gender != 0) {
        self.studySliderInt = 0;
        self.breakSliderInt = 0;
    }

    if (self.age == 0 || self.gender == 0){
        self.age = 0;
        self.gender = 0;
        self.ADHD = 0;
        self.ADD = 0;
        self.dyslexia = 0;
        self.studySliderInt = self.sldStudySlider.value;
        self.breakSliderInt = self.sldBreakSlider.value;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}
@end

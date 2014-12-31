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

@interface AddInfoViewController ()<UIPageViewControllerDataSource>

@property NSInteger studySliderInt;
@property NSInteger breakSliderInt;
@property NSInteger age;
@property NSInteger gender;
@property NSInteger ADHD;

@property NSArray *alberts;

@end

@implementation AddInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];

    [self.pageViewController setDataSource:self];

    UserInfoOneViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];

    NSLog(@"Arrrraaayyy %@", viewControllers);

    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];

    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 260);

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

    self.studySliderInt = 0;
    self.breakSliderInt = 0;

    NSLog(@"1st %ld", (long)self.studySliderInt);
    NSLog(@"1st %ld", (long)self.breakSliderInt);
}

#pragma mark UIPageController

- (UserInfoOneViewController *)viewControllerAtIndex:(NSInteger)index{

//    if ([self.pageTitles count] == 0 || index >= [self.pageTitles count]) {
//        return nil;
//    }

    // Create a new view controller and pass suitable data.

    UserInfoOneViewController *pageOne = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    [pageOne view];
    UserInfoTwoViewController *pageTwo = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentTwoViewController"];
    [pageTwo view];
    
    self.pageViews =@[pageOne.userInfoOneView, pageTwo.userInfoTwoView];

    pageOne.pageOneLabels = pageOne.pageOneLabels[index];
    pageTwo.pageTwoLabels = pageTwo.pageTwoLabels[index];
    pageOne.pageIndex = index;
    pageTwo.pageIndex = index;

    return pageTwo;
}

#pragma mark - Page View Controller Data Source

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = ((UserInfoOneViewController *) viewController).pageIndex;

    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }

    index--;
    return [self viewControllerAtIndex:index];
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{

    NSUInteger index = ((UserInfoOneViewController *) viewController).pageIndex;

    if (index == NSNotFound) {
        return nil;
    }

    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [self.pageTitles count];
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

#pragma mark Sliders 

- (IBAction)onStudySlide:(UISlider *)sender {

    UserInfoOneViewController *age = [UserInfoOneViewController new];
    UserInfoOneViewController *ADHDSwitch =[UserInfoOneViewController new];
    UserInfoOneViewController *pickGender = [UserInfoOneViewController new];

    self.lblStudyTime.text =[[NSString alloc] initWithFormat:@"%.0fm", self.sldStudySlider.value];
    self.studySliderInt = self.sldStudySlider.value;
    age.txtAge.text = @"0";
    [ADHDSwitch.SwtchADHDSwitch setOn:NO animated:YES];
    [pickGender.pickGenderPicker selectRow:0 inComponent:0 animated:YES];
}
- (IBAction)onBreakTime:(UISlider *)sender {
    UserInfoOneViewController *ADHDSwitch =[UserInfoOneViewController new];
    UserInfoOneViewController *pickGender = [UserInfoOneViewController new];

    self.lblBreakTime.text = [[NSString alloc] initWithFormat:@"%.0fm", self.sldBreakSlider.value];
    self.breakSliderInt = self.sldBreakSlider.value;
    [ADHDSwitch.SwtchADHDSwitch setOn:NO animated:YES];
    [pickGender.pickGenderPicker selectRow:0 inComponent:0 animated:YES];
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

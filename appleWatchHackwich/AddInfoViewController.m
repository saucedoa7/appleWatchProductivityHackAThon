// VC2
//  AddInfoViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/24/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "AddInfoViewController.h"
#import "UserInfoOneViewController.h"
#import "UserInfoTwoViewController.h"

@interface AddInfoViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIAlertViewDelegate>

@end

@implementation AddInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 260);

    [self addChildViewController:self.pageViewController];

    [self.view addSubview:self.pageControl];
    [[self view] addSubview:[self.pageViewController view]];
    [self.pageViewController didMoveToParentViewController:self];

    [self.view sendSubviewToBack:[self.pageViewController view]];

    self.studySliderInt = self.sldStudySlider.value;
    self.breakSliderInt = self.sldBreakSlider.value;
}

-(void)viewWillAppear:(BOOL)animated{
//
    NSLog(@"AddInfo View will Appear");
    [self GetData];

    if (!(self.studySliderInt == 0) || !(self.breakSliderInt == 0)) {

        self.sldStudySlider.value = self.studySliderInt;
        self.sldBreakSlider.value = self.breakSliderInt;

        self.lblStudyTime.text = [NSString stringWithFormat:@"%ldm", (long)self.studySliderInt];
        self.lblBreakTime.text = [NSString stringWithFormat:@"%ldm", (long)self.breakSliderInt];
    }

    [self storeData];

    NSLog(@"\nPassing AddInfoVC ViewDidApp Current Age %ld, Gender %ld, ADHD %ld, ADD %ld, Dys %ld, StudyInt %ld, BreakInt %ld, Study %ld ,Break %ld",(long)self.age,(long)self.gender,(long)self.ADHD,(long)self.ADD,(long)self.Dys,(long)self.studySliderInt,(long)self.breakSliderInt,(long)self.studyTime,(long)self.breakTime);
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

    [self GetData];

    self.lblStudyTime.text =[[NSString alloc] initWithFormat:@"%.0fm", round(self.sldStudySlider.value)];
    self.studySliderInt = round(self.sldStudySlider.value);
    NSLog(@"SLider initial values Study %ld Break %ld", (long)self.studySliderInt, (long)self.breakSliderInt);

    [self overRide];

    self.age = 0;
    self.sleep = 0;
    self.gender = 0;

    [self storeData];

    [self saveSliderValues];
}

- (IBAction)onBreakTime:(UISlider *)sender {


    [self GetData];

    self.lblBreakTime.text =[[NSString alloc] initWithFormat:@"%.0fm", round(self.sldBreakSlider.value)];
    self.breakSliderInt = round(self.sldBreakSlider.value);
    NSLog(@"SLider initial values Study %ld Break %ld", (long)self.studySliderInt, (long)self.breakSliderInt);

    [self overRide];

    self.age = 0;
    self.sleep = 0;
    self.gender = 0;

    [self storeData];
}

- (IBAction)onDoneButtonPressed:(UIButton *)sender {

    [self viewDidDisappear:NO];

    NSLog(@"DONE BUTTON WAS PRESSED!!!!!");
    [self GetData];

    if (self.age == 0 || self.gender == 0) {
        [self storeData];
    }

    if (!(self.age == 0) || !(self.gender == 0)) {
        [self.sldStudySlider setValue:0.0];
        [self.sldBreakSlider setValue:0.0];
    }
}

-(void)overRide{

    UserInfoOneViewController *pageOne = [[UserInfoOneViewController alloc] initWithNibName:@"UserInfoOneViewController" bundle:nil];
    UserInfoTwoViewController *pageTwo = [[UserInfoTwoViewController alloc] initWithNibName:@"UserInfoTwoViewController" bundle:nil];

    self.age = 0;
    pageOne.txtAge.text = @"0";
    self.gender = 0;
    [pageOne.pickGenderPicker selectRow:0 inComponent:0 animated:YES];

    //http://stackoverflow.com/questions/14148037/access-switch-value-from-different-view-controller

    self.ADD = 0;
    pageTwo.switchADDSwitch = 0;
    self.ADHD = 0;
    pageTwo.SwtchADHDSwitch = 0;
    self.Dys = 0;
    pageTwo.switchDyslexiaSwitch = 0;
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

    NSLog(@"\nStoring AddInfoVC Current Age %ld, Gender %ld, ADHD %ld, ADD %ld, Dys %ld, StudyInt %ld, BreakInt %ld, Study %ld ,Break %ld",(long)self.age,(long)self.gender,(long)self.ADHD,(long)self.ADD,(long)self.Dys,(long)self.studySliderInt,(long)self.breakSliderInt,(long)self.studyTime,(long)self.breakTime);

}

-(void)GetData{

#pragma mark Get Data from other VC's

    NSUserDefaults *currentSettings = [[NSUserDefaults alloc] initWithSuiteName:@"group.A1Sauce.TodayExtensionSharingDefaults"];
    NSInteger newAge = [currentSettings integerForKey:@"CurrentAge"];
    NSInteger newGender = [currentSettings integerForKey:@"CurrentGender"];
    NSInteger newADHD = [currentSettings integerForKey:@"CurrentADHD"];
    NSInteger newADD = [currentSettings integerForKey:@"CurrentADD"];
    NSInteger newDys = [currentSettings integerForKey:@"CurrentDys"];

    NSInteger newStudyInt = [currentSettings integerForKey:@"CurrentStudyInt"];
    NSInteger newBreakInt = [currentSettings integerForKey:@"CurrentBreakInt"];

    self.age = newAge;
    self.gender = newGender;
    self.ADHD = newADHD;
    self.ADD = newADD;
    self.Dys = newDys;

    self.studySliderInt = newStudyInt;
    self.breakSliderInt = newBreakInt;

    self.studyTime = self.studySliderInt;
    self.breakTime = self.breakSliderInt;

    NSLog(@"\nGetting data AddInf0 VC Current Age %ld, Gender %ld, ADHD %ld, ADD %ld, Dys %ld, StudyInt %ld, BreakInt %ld, Study %ld ,Break %ld",(long)self.age,(long)self.gender,(long)self.ADHD,(long)self.ADD,(long)self.Dys,(long)self.studySliderInt,(long)self.breakSliderInt,(long)self.studyTime,(long)self.breakTime);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

-(void)saveSliderValues{
    [self GetData];

    NSLog(@"Delegate study %ld break %ld", self.studySliderInt, self.breakSliderInt);
    [self.delegate sendingStudyValue:self.studySliderInt andBreakValue:self.breakSliderInt];

}
@end
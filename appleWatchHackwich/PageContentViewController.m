//
//  PageContentViewController.m
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/18/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()


@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.imgMainImage.image = [UIImage imageNamed:self.imageFile];
    self.lblTestLAbel.text = self.titleText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
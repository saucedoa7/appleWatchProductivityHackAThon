//
//  PageContentViewController.h
//  appleWatchHackwich
//
//  Created by Albert Saucedo on 12/18/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imgMainImage;
@property (strong, nonatomic) IBOutlet UILabel *lblTestLAbel;


@property NSInteger *pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@end

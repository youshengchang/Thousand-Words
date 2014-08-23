//
//  TWPhotoDetailViewController.h
//  Thousand Words
//
//  Created by yousheng chang on 8/22/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;
@interface TWPhotoDetailViewController : UIViewController
@property (strong, nonatomic) Photo *photo;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)addFilterButtonPressed:(UIButton *)sender;
- (IBAction)deleteButtonPressed:(UIButton *)sender;

@end

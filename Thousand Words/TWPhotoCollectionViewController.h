//
//  TWPhotoCollectionViewController.h
//  Thousand Words
//
//  Created by yousheng chang on 8/20/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface TWPhotoCollectionViewController : UICollectionViewController

@property (strong, nonatomic)Album *album;

- (IBAction)cameraBarButtonPressed:(UIBarButtonItem *)sender;

@end

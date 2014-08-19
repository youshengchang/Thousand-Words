//
//  TWAlbumTableViewController.h
//  Thousand Words
//
//  Created by yousheng chang on 8/18/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWAlbumTableViewController : UITableViewController 
@property (strong, nonatomic)NSMutableArray *albums;
- (IBAction)addAlbumBarButtonPressed:(UIBarButtonItem *)sender;

@end

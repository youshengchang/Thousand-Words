//
//  TWPhotoDetailViewController.m
//  Thousand Words
//
//  Created by yousheng chang on 8/22/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "TWPhotoDetailViewController.h"
#import "Photo.h"
#import "TWFilterCollectionViewController.h"

@interface TWPhotoDetailViewController ()

@end

@implementation TWPhotoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.imageView.image = self.photo.image;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Filter Segue"]){
        if([segue.destinationViewController isKindOfClass:[TWFilterCollectionViewController class]]){
            TWFilterCollectionViewController *targetViewController = segue.destinationViewController;
            targetViewController.photo = self.photo;
        }
    }
}


- (IBAction)addFilterButtonPressed:(UIButton *)sender {
    NSLog(@"addFilter!");
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
    
    [[self.photo managedObjectContext] deleteObject:self.photo];
    NSLog(@"%@ %@", self.photo, [self.photo managedObjectContext]);
    NSError *error = nil;
    
    [[self.photo managedObjectContext] save:&error];
    
    if(error){
        NSLog(@"error");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end

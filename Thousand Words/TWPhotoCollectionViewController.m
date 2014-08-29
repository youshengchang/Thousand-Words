//
//  TWPhotoCollectionViewController.m
//  Thousand Words
//
//  Created by yousheng chang on 8/20/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "TWPhotoCollectionViewController.h"
#import "TWPhotoCollectionViewCell.h"
#import "Photo.h"
#import "TWPictureDataTransformer.h"
#import "TWCoreDateHelper.h"
#import "TWPhotoDetailViewController.h"

@interface TWPhotoCollectionViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic)NSMutableArray *photos; //UI Images

@end

@implementation TWPhotoCollectionViewController

-(NSMutableArray *)photos
{
    if(!_photos){
        _photos = [[NSMutableArray alloc]init];
        
    }
    return _photos;
    
}
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
    NSSet *unorderedPhotos = self.album.photos;
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortedPhotos = [unorderedPhotos sortedArrayUsingDescriptors:@[dateDescriptor]];
    self.photos = [sortedPhotos mutableCopy];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSSet *unorderedPhotos = self.album.photos;
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortedPhotos = [unorderedPhotos sortedArrayUsingDescriptors:@[dateDescriptor]];
    self.photos = [sortedPhotos mutableCopy];
    
    [self.collectionView reloadData];
    
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
    if([segue.identifier isEqualToString:@"detailSegue"]){
        if([segue.destinationViewController isKindOfClass:[TWPhotoDetailViewController class]]){
            TWPhotoDetailViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems]lastObject];
            
            Photo *selectedPhoto = self.photos[indexPath.row];
            targetViewController.photo = selectedPhoto;
        }
    }
}

#pragma mark - UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Photo Cell";
    TWPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    Photo *photo = self.photos[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = photo.image;
    
    return cell;
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.photos count];
}
- (IBAction)cameraBarButtonPressed:(UIBarButtonItem *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - Helper Methods
-(Photo *)photoFromImage:(UIImage *)image
{
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[TWCoreDateHelper managedObjectContext]];
    photo.image = image;
    photo.date = [NSDate date];
    photo.albumBook = self.album;
    NSError *error = nil;
    if(![[photo managedObjectContext] save:&error]){
        //Error in saving
        NSLog(@"%@", error);
    }
    return photo;
    
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Finished picking");
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if(!image) image = info[UIImagePickerControllerOriginalImage];
    [self.photos addObject:[self photoFromImage:image]];
    
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"Cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end

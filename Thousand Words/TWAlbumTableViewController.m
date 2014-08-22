//
//  TWAlbumTableViewController.m
//  Thousand Words
//
//  Created by yousheng chang on 8/18/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "TWAlbumTableViewController.h"
#import "Album.h"
#import "TWCoreDateHelper.h"
#import "TWPhotoCollectionViewController.h"


@interface TWAlbumTableViewController () <UIAlertViewDelegate>

@end

@implementation TWAlbumTableViewController

-(NSMutableArray *)albums
{
    if(!_albums){
        _albums = [[NSMutableArray alloc]init];
    }
    return _albums;
}

#pragma mark - IBActions
- (IBAction)addAlbumBarButtonPressed:(UIBarButtonItem *)sender {
    UIAlertView *newAlbumAlertView = [[UIAlertView alloc]initWithTitle:@"Enter New Album Name" message:nil delegate:self
cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [newAlbumAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [newAlbumAlertView show];
    
}

#pragma mark helper methods
-(Album *)albumWithName:(NSString *)name
{
   
    NSManagedObjectContext *context = [TWCoreDateHelper managedObjectContext];
    
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = name;
    album.date = [NSDate date];
    
    NSError *error = nil;
    if(![context save:&error]){
        //we have en error
        NSLog(@"%@", error);
    }
    return album;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    NSError *error = nil;
    NSArray *fetchAlbums =[[TWCoreDateHelper managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    self.albums = [fetchAlbums mutableCopy];
    [self.tableView reloadData];
                                     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIAlert view delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        NSString *alertText = [alertView textFieldAtIndex:0].text;
        //NSLog(@"My album is %@", alertText);
        [self.albums addObject:[self albumWithName:alertText]];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.albums count]-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.albums count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Album *selectedAlbum = self.albums[indexPath.row];
    cell.textLabel.text = selectedAlbum.name;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Album Chosen"]){
        if([segue.destinationViewController isKindOfClass:[TWPhotoCollectionViewController class]]){
            NSIndexPath *path = [self.tableView indexPathForSelectedRow];
            TWPhotoCollectionViewController *targetViewController = segue.destinationViewController;
            targetViewController.album = self.albums[path.row];
            
        }
    }
    
}


@end

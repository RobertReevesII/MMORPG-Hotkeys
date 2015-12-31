//
//  RLRGamesTableViewController.m
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 12/16/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

@import CoreData;
#import "RLRGamesTableViewController.h"
#import "RLRHotkeysTableViewController.h"
#import "RLRDataController.h"
#import "RLRGame.h"


@interface RLRGamesTableViewController () <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSArray *gamesArray;
@end


@implementation RLRGamesTableViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    NSLog(@"1");
    [self initializeFetchedResultsController];
    NSLog(@"2");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSFetchedResultsController

- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                 ascending:YES];
    [request setSortDescriptors:@[nameSort]];
    
    RLRDataController *dataController = [[RLRDataController alloc]
                                         init];
    
    NSManagedObjectContext *moc = dataController.managedObjectContext;
    
    [self setFetchedResultsController:[[NSFetchedResultsController alloc]
                                       initWithFetchRequest:request
                                       managedObjectContext:moc
                                       sectionNameKeyPath:nil
                                       cacheName:nil]];
    [[self fetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController %@\n%@", [error localizedDescription],
              [error userInfo]);
        abort();
    }
    NSLog(@"%@", self.fetchedResultsController.fetchedObjects);
}

#pragma mark - Table view data source

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSLog(@"cellforrowcalled");
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
     RLRGame *game = [self.fetchedResultsController objectAtIndexPath:indexPath];
     
     NSLog(@"%@", game.name);
     
     // Configure the cell...
     
     
     // Should I do this in a custom UITableViewCell?
     cell.textLabel.text = game.name;
     
     return cell;
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetchedResultsController.fetchedObjects count];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

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
#import "AppDelegate.h"


@interface RLRGamesTableViewController () <NSFetchedResultsControllerDelegate, UITableViewDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end


@implementation RLRGamesTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initializeFetchedResultsController];

    self.navigationItem.title = @"Games";
    [self.tableView reloadData];
}

#pragma mark - NSFetchedResultsController

- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                 ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:nameSort, nil];
    [request setSortDescriptors:sortDescriptors];
    AppDelegate *myAppDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = myAppDelegate.dataController.managedObjectContext;
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]
                                                            initWithFetchRequest:request
                                                            managedObjectContext:moc
                                                            sectionNameKeyPath:nil
                                                            cacheName:@"gamesCache"];
    self.fetchedResultsController = fetchedResultsController;
    [[self fetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController %@\n%@", [error localizedDescription],
              [error userInfo]);
        abort();
    }
}

#pragma mark - Table view data source

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
     RLRGame *game = self.fetchedResultsController.fetchedObjects[indexPath.row];

     cell.textLabel.text = game.name;
     
     return cell;
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetchedResultsController.fetchedObjects count];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Present HotkeysTableViewController initiated with game
    RLRGame *game =[[self fetchedResultsController] objectAtIndexPath:indexPath];
    RLRHotkeysTableViewController *htvc = [[RLRHotkeysTableViewController alloc] initWithGame:game];
    [self.navigationController pushViewController:htvc
                                         animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

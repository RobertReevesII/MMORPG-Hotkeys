//
//  RLRHotkeysTableViewController.m
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 12/16/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

#import "RLRHotkeysTableViewController.h"
#import "RLRGame.h"
#import "RLRHotkey.h"
#import "RLRDataController.h"
#import "AppDelegate.h"
#import "RLRHotkeyDetailViewController.h"

@interface RLRHotkeysTableViewController () <NSFetchedResultsControllerDelegate, UITableViewDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation RLRHotkeysTableViewController

- (instancetype)initWithGame:(RLRGame *)game {
    self = [super init];
    if (self) {
        _game = game;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initializeFetchedResultsController];
    
    self.navigationItem.title = _game.name;
    [self.tableView reloadData];
}

#pragma mark - NSFetchedResultsController

- (void)initializeFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotkey"];
    NSSortDescriptor *functionSort = [NSSortDescriptor sortDescriptorWithKey:@"function"
                                                                   ascending:YES];
    [request setSortDescriptors:@[functionSort]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"game.name == %@", self.game.name];
    request.predicate = predicate;
    AppDelegate *myAppDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = myAppDelegate.dataController.managedObjectContext;
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]
                                                            initWithFetchRequest:request
                                                            managedObjectContext:moc
                                                            sectionNameKeyPath:nil
                                                            cacheName:self.game.name];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.fetchedResultsController fetchedObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                   reuseIdentifier:@"UITableViewCell"];
    RLRHotkey *hotkey = self.fetchedResultsController.fetchedObjects[indexPath.row];

    cell.textLabel.text = hotkey.function;
    cell.detailTextLabel.text = hotkey.keys;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RLRHotkeyDetailViewController *hdvc = [[RLRHotkeyDetailViewController alloc] init];
    RLRHotkey *hotkey = self.fetchedResultsController.fetchedObjects[indexPath.row];
    hdvc.hotkey = hotkey;
    [self.navigationController pushViewController:hdvc
                                         animated:YES];
}

@end

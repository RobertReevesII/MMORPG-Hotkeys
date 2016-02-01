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
#import "RLRHotkeyDetailTableViewCell.h"

@interface RLRHotkeysTableViewController () <NSFetchedResultsControllerDelegate, UITableViewDelegate,
                                                UINavigationControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) RLRGame *game;

@end

@implementation RLRHotkeysTableViewController

- (instancetype)initWithGame:(RLRGame *)game {
    self = [super init];
    if (self) {
        _game = game;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44;
    }
    return self;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"RLRHotkeyDetailTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"HotkeyCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initializeFetchedResultsController];

    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = self.game.name;
    if ([self.game.name isEqualToString:@"Final Fantasy XIV: A Realm Reborn"]) {
        self.navigationItem.title = @"Final Fantasy XIV";
    }
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
    RLRHotkey *hotkey = self.fetchedResultsController.fetchedObjects[indexPath.row];

    RLRHotkeyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotkeyCell"];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.functionLabel.numberOfLines = 0;
    cell.functionLabel.text = [hotkey.function stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    cell.keysLabel.numberOfLines = 0;
    cell.keysLabel.text = [hotkey.keys stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return cell;
}
@end

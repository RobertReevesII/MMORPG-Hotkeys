//
//  RLRDataController.m
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 12/21/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

#import "RLRDataController.h"
#import "RLRGame.h"
#import "RLRHotkey.h"
#import "CHCSVParser.h"

@implementation RLRDataController

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    [self initializeCoreData];
    return self;
}

#pragma mark - Initializing Core Data

- (void)initializeCoreData {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model"
                                              withExtension:@"momd"];
    
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc]
                                 initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]
                                         initWithManagedObjectModel:mom];
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc]
                                   initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    [moc setPersistentStoreCoordinator:psc];
    [self setManagedObjectContext:moc];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory
                                               inDomains:NSUserDomainMask] lastObject];
    
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"DataModel.sqlite"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^(void) {
                       NSError *error = nil;
                       NSPersistentStoreCoordinator *psc = [[self managedObjectContext]
                                                            persistentStoreCoordinator];
                       [psc addPersistentStoreWithType:NSSQLiteStoreType
                                         configuration:nil
                                                   URL:storeURL
                                               options:nil
                                                 error:&error];
                   });
}

#pragma mark - Preloading Core Data

- (void)preloadGames {
    // Get data as an array of arrays of strings from games.csv
    NSBundle *applicationBundle = [NSBundle mainBundle];
    NSString *path = [applicationBundle pathForResource:@"games"
                                                 ofType:@"csv"];
    NSURL *csvURL = [NSURL fileURLWithPath:path];
    NSArray *parsedArray = [NSArray arrayWithContentsOfCSVURL:csvURL];
    
    
    
    // Insert data into Core Data
    for (NSArray *array in parsedArray) {
        RLRGame *managedGame = [NSEntityDescription insertNewObjectForEntityForName:@"Game"
                                                             inManagedObjectContext:[self managedObjectContext]];
        
        NSMutableSet *mutableHotkeySet = [[NSMutableSet alloc] init];
        
        RLRHotkey *managedHotkey = [NSEntityDescription insertNewObjectForEntityForName:@"Hotkey"
                                                                 inManagedObjectContext:[self managedObjectContext]];
        managedHotkey.game.name = [array objectAtIndex:0];
        
        for (NSString *string in array) {
            
            // If index == 0, string is game.name
            if ([array indexOfObject:string] == 0) {
                managedGame.name = string;
                // Save
                NSError *error = nil;
                if ([[self managedObjectContext] save:&error] == NO) {
                    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                }
            }
            // If index != 0, save string to appropriate hotkey property
            if ([array indexOfObject:string] != 0) {
                
                // If index is odd, string should be inserted into hotkeys as function
                if (([array indexOfObject:string] % 2) == 1) {
                    managedHotkey.function = string;
                    // If both properties of hotkey are set, save it and reset it
                    if (managedHotkey.function && managedHotkey.keys) {
                        [mutableHotkeySet addObject:managedHotkey];
                        NSError *error = nil;
                        if ([[self managedObjectContext] save:&error] == NO) {
                            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                        }
                        managedHotkey = [NSEntityDescription insertNewObjectForEntityForName:@"Hotkey"
                                                                      inManagedObjectContext:[self managedObjectContext]];
                    }
                }
                // If index is even, string should be inserted into hotkeys as keys
                else if (([array indexOfObject:string] % 2) == 0) {
                    managedHotkey.keys = string;
                    if (managedHotkey.keys && managedHotkey.function) {
                        [mutableHotkeySet addObject:managedHotkey];
                        NSError *error = nil;
                        if ([[self managedObjectContext] save:&error] == NO) {
                            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                        }
                        managedHotkey = [NSEntityDescription insertNewObjectForEntityForName:@"Hotkey"
                                                                      inManagedObjectContext:[self managedObjectContext]];
                    }
                }
                else {
                    NSLog(@"-indexexOfobjectsPassingTest: Test Failed for %@", string);
                }
                
            }
        }
        // managedGame properties SHOULD be set by here
        NSSet *hotkeySet = [[NSSet alloc] initWithSet:mutableHotkeySet];
        managedGame.hotkeys = hotkeySet;
        NSError *error = nil;
        if ([[self managedObjectContext] save:&error] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
    }
}


@end

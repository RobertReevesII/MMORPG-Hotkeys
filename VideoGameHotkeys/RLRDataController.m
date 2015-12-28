//
//  RLRDataController.m
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 12/21/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

#import "RLRDataController.h"
#import "RLRGame.h"

@implementation RLRDataController

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    [self initializeCoreData];
    [self initialCoreDataPopulation];
    
    return self;
}

- (void)initializeCoreData {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model"
                                              withExtension:@"momd"];
    NSLog(@"%@", modelURL);
    
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
                         NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType
                                                                      configuration:nil
                                                                                URL:storeURL
                                                                            options:nil
                                                                              error:&error];
                         NSAssert(store != nil, @"Error initializing PSC: %@/n%@", [error localizedDescription],
                                  [error userInfo]);
                     });
}

- (void)initialCoreDataPopulation {
    // Create initial RLRGame
    RLRGame *game1 = [NSEntityDescription insertNewObjectForEntityForName:@"Game"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    game1.name = @"League of Legends";
    
    // Insert intial RLRGame into Managed Object Contezt
    
    
    // Save objects into store
    NSError *error = nil;
    if ([[self managedObjectContext] save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription],
                 [error userInfo]);
    }
}



@end

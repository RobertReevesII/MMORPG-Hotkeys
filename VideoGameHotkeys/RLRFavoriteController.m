//
//  RLRFavoriteController.m
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 1/22/16.
//  Copyright © 2016 Robert Reeves II. All rights reserved.
//

#import "RLRFavoriteController.h"
#import "AppDelegate.h"

@implementation RLRFavoriteController

- (RLRGame *)gameForTitle:(NSString *)title {
    RLRGame *correctGame;
    AppDelegate *myAppDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = myAppDelegate.dataController.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Game"];
    
    NSError *error = nil;
    NSArray *requestedObjects = [moc executeFetchRequest:request
                                                   error:&error];
    for (RLRGame *game in requestedObjects) {
        if ([game.name isEqualToString:title]) {
            correctGame = game;
            break;
        }
    }
    return correctGame;
}

@end

//
//  RLRDataController.h
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 12/21/15.
//  Copyright © 2015 Robert Reeves II. All rights reserved.
//

@import CoreData;
@import Foundation;
#import "CHCSVParser.h"

@interface RLRDataController : NSObject <CHCSVParserDelegate>

@property (strong) NSManagedObjectContext *managedObjectContext;

- (void)initializeCoreData;
- (void)preloadGames;

@end

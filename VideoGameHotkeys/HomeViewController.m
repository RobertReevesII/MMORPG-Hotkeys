//
//  HomeViewController.m
//  VideoGameHotkeys
//
//  Created by Robert Reeves II on 1/19/16.
//  Copyright © 2016 Robert Reeves II. All rights reserved.
//

#import "HomeViewController.h"
#import "RLRGamesTableViewController.h"
#import "RLRHotkeysTableViewController.h"
#import "RLRFavoriteController.h"

@interface HomeViewController ()

@property (strong, nonatomic) IBOutlet UIButton *exploreGamesButton;
@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImage *logo = [UIImage imageNamed:@"HotkeysInside"];
    self.logo.image = logo;
    
    self.navigationController.navigationBarHidden = YES;

    self.exploreGamesButton.layer.cornerRadius = 10;
    self.exploreGamesButton.layer.borderWidth = 2;
    self.exploreGamesButton.layer.borderColor = [[UIColor blackColor] CGColor];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    UIButton *favButton = self.favoriteButton;
    favButton.layer.cornerRadius = 10;
    favButton.layer.borderWidth = 2;
    favButton.layer.borderColor = [[UIColor blackColor] CGColor];
    NSString *favoriteName = [defaults valueForKey:@"favoriteTitle"];
    
    
    if (favoriteName) {
        
        if ([favoriteName isEqualToString:@"Final Fantasy XIV: A Realm Reborn"]) {
            favoriteName = @"Final Fantasy XIV";
        }
        if ([favoriteName isEqualToString:@"Lord of the Rings Online"]) {
            favoriteName = @"LOTR Online";
        }
        if ([favoriteName isEqualToString:@"Star Wars: The Old Republic"]) {
            favoriteName = @"Star Wars: TOR";
        }
        
        [favButton setTitle:favoriteName
                 forState:UIControlStateNormal];
        
    }
    else {[favButton setTitle:@"Favorite"
                   forState:UIControlStateNormal];
    }
}

- (IBAction)exploreGames:(id)sender {
    RLRGamesTableViewController *gtvc = [[RLRGamesTableViewController alloc] init];
    gtvc.navigationItem.title = @"Games";
    [self.navigationController pushViewController:gtvc
                                         animated:YES];
}

- (IBAction)goToFavorite:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *title = [defaults valueForKey:@"favoriteTitle"];
    if (!title) {
        return;
    }
    RLRFavoriteController *fvc = [[RLRFavoriteController alloc] init];
    RLRGame *game = [fvc gameForTitle:title];

    RLRHotkeysTableViewController *htvc = [[RLRHotkeysTableViewController alloc] initWithGame:game];
    [self.navigationController pushViewController:htvc
                                         animated:YES];
}

- (IBAction)setFavorite:(id)sender {
    RLRGamesTableViewController *gtvc = [[RLRGamesTableViewController alloc] initWithFavorite];
    gtvc.navigationItem.title = @"Set Favorite";
    [self.navigationController pushViewController:gtvc
                                         animated:YES];
}



@end

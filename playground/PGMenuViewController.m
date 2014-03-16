//
//  PGMenuViewController.m
//  playground
//
//  Created by Hendrik Frömmel on 14.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import "PGMenuViewController.h"
#import "PGPodsViewController.h"

#import "IIViewDeckController.h"

@interface PGMenuViewController () <UITableViewDelegate, IIViewDeckControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *menuTable;
@property (strong, nonatomic) NSMutableArray *navigationItems;

@end

@implementation PGMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.viewDeckController.delegate = self;
    self.menuTable.delegate = self;
    
    self.navigationItems = NSMutableArray.new;
    [self.navigationItems addObject:@"loginController"];
    [self.navigationItems addObject:@"podsController"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.navigationItems.count) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UINavigationController *navigationController = UINavigationController.new;
        UIViewController *viewController = (PGPodsViewController *)[storyboard instantiateViewControllerWithIdentifier:self.navigationItems[indexPath.row]];
        
        [navigationController setViewControllers:@[viewController]];
        
        [self.viewDeckController setCenterController: navigationController];
        [self.viewDeckController toggleLeftViewAnimated:YES];
    }
}

@end

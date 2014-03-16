//
//  PGPodsViewController.m
//  playground
//
//  Created by Hendrik Frömmel on 14.03.14.
//  Copyright (c) 2014 Hendrik Frömmel. All rights reserved.
//

#import "PGPodsViewController.h"
#import "PGPersistentStack.h"
#import "PGPodsImporter.h"
#import "PGPodsWebService.h"
#import "Pod.h"
#import "FetchedResultsControllerDataSource.h"
#import "PGPodDetailViewController.h"

@interface PGPodsViewController () <FetchedResultsControllerDataSourceDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) PGPersistentStack *persistentStack;
@property (strong, nonatomic) PGPodsWebService  *webservice;
@property (strong, nonatomic) PGPodsImporter    *importer;

@property (strong, nonatomic) NSManagedObjectContext             *managedObjectContext;
@property (strong, nonatomic) FetchedResultsControllerDataSource *dataSource;

@end

@implementation PGPodsViewController

- (void)awakeFromNib {
    self.persistentStack = [[PGPersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
    self.webservice = [[PGPodsWebService alloc] init];
    self.importer = [[PGPodsImporter alloc] initWithContext:self.persistentStack.backgroundManagedObjectContext webservice:self.webservice];
    
    self.managedObjectContext = self.persistentStack.managedObjectContext;
    [self.importer import];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pod"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"version" ascending:NO]];
    
    self.dataSource = [[FetchedResultsControllerDataSource alloc] initWithTableView:self.tableView];
    self.dataSource.delegate = self;
    self.dataSource.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                   managedObjectContext:self.managedObjectContext
                                                                                     sectionNameKeyPath:nil
                                                                                              cacheName:nil];
    self.dataSource.reuseIdentifier = @"Cell";
    [self.tableView reloadData];
}

- (NSURL*)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"PGModel" withExtension:@"momd"];
}

- (NSURL*)storeURL
{
    NSURL* documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                       inDomain:NSUserDomainMask
                                                              appropriateForURL:nil
                                                                         create:YES
                                                                          error:NULL];
    
    return [documentsDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

- (void)configureCell:(UITableViewCell *)cell withObject:(Pod *)object
{
    cell.textLabel.text = object.name;
    cell.detailTextLabel.text = object.version;
}

- (void)deleteObject:(id)object
{
    NSLog(@"Delete object");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PGPodDetailViewController *detailViewController = segue.destinationViewController;
    detailViewController.pod = self.dataSource.selectedItem;
}

@end

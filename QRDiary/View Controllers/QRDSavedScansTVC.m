//
//  QRDSavedScansTVC.m
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/18/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//

#import "QRDSavedScansTVC.h"
#import "QRDScan.h"
#import "QRDViewScanViewController.h"
#import "QRDSavedScanTVCell.h"

@interface QRDSavedScansTVC ()

@property (strong, nonatomic)NSArray *scans;

@end

@implementation QRDSavedScansTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.dataStore = [QRDCoreDataStore sharedDataStore];
    
    self.scans = self.dataStore.fetchSavedScans;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.2 green:0.53 blue:0.78 alpha:1.0];
}

- (void)viewWillAppear:(BOOL)animated {
    
    // This is needed because if left swipe isn't completed, the navbar
    // disappears because of the setting in the home view controller
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataStore.fetchSavedScans.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scanCell" forIndexPath:indexPath];
    
    QRDScan *scan = self.dataStore.fetchSavedScans[indexPath.row];
    
    cell.textLabel.text = scan.scanText;
    
    //customizing cells separators
    [cell.contentView.layer setBorderColor:[UIColor colorWithRed:0.2 green:0.53 blue:0.78 alpha:1.0].CGColor];
    [cell.contentView.layer setBorderWidth:4.0];
    cell.contentView.clipsToBounds = YES;
    cell.contentView.layer.cornerRadius = 10;
     
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete object from Core Data first
        QRDScan *scanToDelete = self.dataStore.savedScans[indexPath.row];
        [self.dataStore.managedObjectContext deleteObject:scanToDelete];
        [self.dataStore saveContext];
        
        // Refresh array of scans
        self.scans = self.dataStore.fetchSavedScans;
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//Navigation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"viewScanSegue" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    QRDViewScanViewController *destVC = segue.destinationViewController;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    destVC.textToDisplay = ((QRDScan *)self.scans[indexPath.row]).scanText;
}


@end

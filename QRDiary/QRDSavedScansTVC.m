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

@interface QRDSavedScansTVC ()

@end

@implementation QRDSavedScansTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    self.dataStore = [QRDCoreDataStore sharedDataStore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //delete object from Core Data first
        QRDScan *scanToDelete = self.dataStore.savedScans[indexPath.row];
        [self.dataStore.managedObjectContext deleteObject:scanToDelete];
        [self.dataStore saveContext];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"viewScanSegue" sender:self];
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//    QRDViewScanViewController *destVC = segue.destinationViewController;
//    
//    NSIndexPath *selectedCell = [self.tableView indexPathForSelectedRow];
//
//
//}


@end

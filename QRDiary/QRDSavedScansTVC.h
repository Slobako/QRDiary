//
//  QRDSavedScansTVC.h
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/18/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRDCoreDataStore.h"

@interface QRDSavedScansTVC : UITableViewController 

//instance of sharedDataStore to be able to communicate with Core Data and grab the saved scans which are a property of core data
@property (strong, nonatomic)QRDCoreDataStore *dataStore;

@end

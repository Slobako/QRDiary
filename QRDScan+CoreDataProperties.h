//
//  QRDScan+CoreDataProperties.h
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/18/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "QRDScan.h"

NS_ASSUME_NONNULL_BEGIN

@interface QRDScan (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *scanText;
@property (nullable, nonatomic, retain) NSDate *scanDate;

@end

NS_ASSUME_NONNULL_END

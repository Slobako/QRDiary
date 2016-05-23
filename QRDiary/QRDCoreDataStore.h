//
//  QRDCoreDataStore.h
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/19/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>


@interface QRDCoreDataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property(strong, nonatomic)NSMutableArray *savedScans;

+(instancetype)sharedDataStore;
-(void)saveContext;
-(NSURL *)applicationDocumentsDirectory;
-(NSMutableArray *)fetchSavedScans;

@end

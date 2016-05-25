//
//  QRDSavedScanTVCell.m
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/25/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//

#import "QRDSavedScanTVCell.h"
#import "QRDSavedScansTVC.h"

@interface QRDSavedScanTVCell ()

@property (weak, nonatomic) IBOutlet UILabel *labelTVCell;


@end


@implementation QRDSavedScanTVCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

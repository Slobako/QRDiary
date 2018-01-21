//
//  QRDViewScanViewController.m
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/23/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//

#import "QRDViewScanViewController.h"

@interface QRDViewScanViewController ()

@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UITextView *savedScanTextView;

@end

@implementation QRDViewScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    self.savedScanTextView.text = self.textToDisplay;
    
    //3 different sizes of detailView depending on the number of lines in scanned text
    NSUInteger numberOfLines = self.savedScanTextView.contentSize.height / self.savedScanTextView.font.lineHeight;
    
    if (numberOfLines < 5) {
        [self.detailView.heightAnchor constraintEqualToConstant:125].active = YES;
    } else if (numberOfLines >= 5 && numberOfLines < 10) {
        [self.detailView.heightAnchor constraintEqualToConstant:250].active = YES;
    } else {
        [self.detailView.heightAnchor constraintEqualToConstant:375].active = YES;
    }
    
    //rounding the corners and setting the color and font
    self.detailView.clipsToBounds = YES;
    self.detailView.layer.cornerRadius = 10;
    self.detailView.backgroundColor = [UIColor colorWithRed:0.2 green:0.53 blue:0.78 alpha:1.0];
    self.savedScanTextView.clipsToBounds = YES;
    self.savedScanTextView.layer.cornerRadius = 10;
    self.savedScanTextView.font = [UIFont fontWithName:@"Helvetica Neue" size:18.0];
}

// IBActions
- (IBAction)returnTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareTapped:(id)sender {
    
    NSString *textToShare = self.savedScanTextView.text;
    
    //intlzr below requires an array for the items that are to be shared, since I have just text, array contains only one element
    NSArray *activityItems = @[textToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    //excluding the activity types I don't want shown
    NSArray *excludeActivities = @[UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo,
                                   UIActivityTypeAirDrop,];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end

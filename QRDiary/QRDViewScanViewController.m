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
    
    self.detailView.clipsToBounds = YES;
    self.detailView.layer.cornerRadius = 10;
    self.savedScanTextView.clipsToBounds = YES;
    self.savedScanTextView.layer.cornerRadius = 10;
    self.savedScanTextView.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0];
    
    self.savedScanTextView.text = self.textToDisplay;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareTapped:(id)sender {
    
    NSString *textToShare = self.savedScanTextView.text;
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

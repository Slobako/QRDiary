//
//  QRDInfoViewController.m
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/31/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//

#import "QRDInfoViewController.h"

@interface QRDInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@end

@implementation QRDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [self setupView];
}

- (void)setupView {
    
    //setting up the Text View look:
    self.infoTextView.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0];
    //add a border frame to TextView
    self.infoTextView.layer.borderWidth = 8.0;
    self.infoTextView.layer.borderColor = [[UIColor colorWithRed:0.2 green:0.53 blue:0.78 alpha:1.0] CGColor];
    //increase text inset
    self.infoTextView.textContainerInset = UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0);
    //round the edges
    self.infoTextView.clipsToBounds = YES;
    self.infoTextView.layer.cornerRadius = 10;
}

- (void)viewWillAppear:(BOOL)animated {
    
    // This is needed because if left swipe isn't completed, the navbar
    // disappears because of the setting in the home view controller
    [self.navigationController setNavigationBarHidden:NO];
}

//to have the text in text view show from top left
- (void)viewDidLayoutSubviews {
    [self.infoTextView setContentOffset:CGPointZero animated:NO];
}

@end

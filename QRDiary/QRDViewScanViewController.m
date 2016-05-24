//
//  QRDViewScanViewController.m
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/23/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//

#import "QRDViewScanViewController.h"

@interface QRDViewScanViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;


@end

@implementation QRDViewScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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

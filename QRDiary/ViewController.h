//
//  ViewController.h
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/9/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong)AVCaptureSession *captureSession;
@property (nonatomic, strong)AVCaptureVideoPreviewLayer *captureVideoLayer;
@property (nonatomic)BOOL scannerReady;

@end


//
//  ViewController.m
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/9/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}

-(void)setupScanner {
    
    //initialize capture session
    self.captureSession = [[AVCaptureSession alloc]init];
    
    //assign default device and media type as video
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    
    //set the defined input for the session
    [self.captureSession addInput:deviceInput];
    
    //specifying output for capture session
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc]init];
    [self.captureSession addOutput:metadataOutput];
    
    //create a new queue
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("scanQueue", NULL);
    
    //set the View Controller (self) as the delegate for metadataOutput object and provide the queue on which the delegate's method will be executed
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //specify the type of metadata I need
    [metadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //setting up capture video layer:
    
    //initialize the layer
    self.captureVideoLayer = [[AVCaptureVideoPreviewLayer alloc]init];
    //set video gravity to fill up the screen
    [self.captureVideoLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    //frame needs CGRect type, that's why bounds
    [self.captureVideoLayer setFrame:self.videoPreviewView.bounds];
    //add captureVideoLayer as a sublayer onto videoPreviewView
    [self.videoPreviewView.layer addSublayer:self.captureVideoLayer];
    
    //run the session
    [self.captureSession startRunning];
    
}

@end

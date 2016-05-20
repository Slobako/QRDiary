//
//  ViewController.m
//  QRDiary
//
//  Created by Slobodan Kovrlija on 5/9/16.
//  Copyright © 2016 Slobodan Kovrlija. All rights reserved.
//

#import "ViewController.h"
#import "QRDSavedScansTVC.h"
#import "QRDScan.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *videoPreviewView;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIButton *viewScannsButton;
@property (weak, nonatomic) IBOutlet UITextView *scanResultTextView;
@property (weak, nonatomic) IBOutlet UIButton *cancelScanButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scanResultTextView.hidden = YES;
    self.scanResultTextView.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0];
    //round the edges
    self.scanResultTextView.clipsToBounds = YES;
    self.scanResultTextView.layer.cornerRadius = 5;
    
    self.cancelScanButton.hidden = YES;
    self.saveButton.hidden = YES;
    
    [self setupScanner];
    
    self.dataStore = [QRDCoreDataStore sharedDataStore];
    
}

-(void)setupScanner {
    
    //initialize capture session
    self.captureSession = [[AVCaptureSession alloc]init];
    
    //assign default device and media type as video
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:nil];
    
    if (!deviceInput) {
        NSLog(@"Error Getting Camera Input");
        return;
    }
    
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
    
    //initialize the layer with the captureSession
    self.captureVideoLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    //set video gravity to fill up the screen
    [self.captureVideoLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //frame needs CGRect type, that's why bounds
    //[self.captureVideoLayer setFrame:self.videoPreviewView.bounds];
    
    self.captureVideoLayer.frame = CGRectMake(0, 0, self.videoPreviewView.frame.size.width, self.videoPreviewView.frame.size.height);
    
    //set video orientaation as portrait
    [[self.captureVideoLayer connection]setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    //add captureVideoLayer as a sublayer onto videoPreviewView
    [self.videoPreviewView.layer insertSublayer:self.captureVideoLayer atIndex:0];
    
    self.scannerReady = YES;
    
}

- (IBAction)scanTapped:(id)sender {
    
    if (self.scannerReady) {
        //run the session
        [self.captureSession startRunning];
        NSLog(@"start running");
    } else {
        //setup the scanner and run the session
        [self setupScanner];
        [self.captureSession startRunning];
    }
    
    self.cancelScanButton.hidden = NO;
    self.scanButton.hidden = YES;
    self.viewScannsButton.hidden = YES;
    self.scanResultTextView.hidden = YES;
    self.saveButton.hidden = YES;
}

- (IBAction)cancelScanTapped:(id)sender {
    
    [self stopScanning];
    self.scanResultTextView.hidden = YES;
}

//implement the delegate method
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects != nil && metadataObjects.count == 1) {
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        
        if ([[metadataObject type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSLog(@"read code: %@", metadataObject.stringValue);
            
            //in order not to modify the autolayout from a background thread, switching to the main thread
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self stopScanning];
                self.scanResultTextView.text = metadataObject.stringValue;
            });
        }
    }
}

-(void)stopScanning {
    
        [self.captureSession stopRunning];
        [self.captureVideoLayer removeFromSuperlayer];
        self.scanButton.hidden = NO;
        self.viewScannsButton.hidden = NO;
        self.scannerReady = NO;
        self.scanResultTextView.hidden = NO;
        self.cancelScanButton.hidden = YES;
        self.saveButton.hidden = NO;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *scanString = self.scanResultTextView.text;
    
    if ([segue.identifier isEqualToString:@"saveSegue"]) {
        QRDSavedScansTVC *destVC = segue.destinationViewController;
        destVC.scanToSave = scanString;
        
        //adding new scan to Core Data
        QRDScan *newScan = (QRDScan *)[NSEntityDescription insertNewObjectForEntityForName:@"QRDScan" inManagedObjectContext:self.dataStore.managedObjectContext];
        newScan.scanText = scanString;
        
        [self.dataStore saveContext];
    }
}

@end

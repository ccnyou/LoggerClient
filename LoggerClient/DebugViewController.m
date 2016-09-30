//
//  DebugViewController.m
//  LoggerClient
//
//  Created by 聪宁陈 on 16/9/30.
//  Copyright © 2016年 ccnyou. All rights reserved.
//

#import "DebugViewController.h"
#import "LoggerClient.h"
#import "ViewController.h"

@interface DebugViewController ()

@property (weak, nonatomic) IBOutlet UITextField *serverTextField;
@property (weak, nonatomic) IBOutlet UITextField *portTextField;
@property (weak, nonatomic) IBOutlet UITextField *testTextField;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;
@property (weak, nonatomic) LoggerClient* client;

@end

@implementation DebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _initApperance];
    [self _updateApperance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LoggerClient *)client {
    if (!_client) {
        _client = [LoggerClient client];
    }
    
    return _client;
}

#pragma mark - UI

- (void)_initApperance {
    self.outputTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.outputTextView.layer.borderWidth = 0.5f;
    self.outputTextView.layer.cornerRadius = 5.0f;
    self.outputTextView.layer.masksToBounds = YES;
}

- (void)_updateApperance {
    if ([self.client isConnected]) {
        self.disconnectButton.enabled = YES;
        self.connectButton.enabled = NO;
        self.sendButton.enabled = YES;
    } else {
        self.disconnectButton.enabled = NO;
        self.connectButton.enabled = YES;
        self.sendButton.enabled = NO;
    }
}

#pragma mark - Event

- (IBAction)_onConnectTouched:(id)sender {
    [self.client connect:self.serverTextField.text port:self.portTextField.text completion:^(NSError *error) {
        if (error) {
            NSLog(@"%s %d error = %@", __FUNCTION__, __LINE__, error);
            NSString* log = [NSString stringWithFormat:@"%s %d error = %@", __FUNCTION__, __LINE__, error];
            self.outputTextView.text = log;;
        } else {
            [self _updateApperance];
        }
    }];
}

- (IBAction)_onDisconnectTouched:(id)sender {
}

- (IBAction)_onBackgroundTouched:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)_onSendTouched:(id)sender {
}

@end

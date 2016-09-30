//
//  ViewController.m
//  LoggerClient
//
//  Created by 聪宁陈 on 16/9/30.
//  Copyright © 2016年 ccnyou. All rights reserved.
//

#import "ViewController.h"
#import "DebugViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)_onDebug:(id)sender {
    DebugViewController* debugController = [[DebugViewController alloc] init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:debugController];
    UIBarButtonItem* closeButton = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(_onClose:)];
    debugController.navigationItem.leftBarButtonItem = closeButton;
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)_onClose:(id)sender {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

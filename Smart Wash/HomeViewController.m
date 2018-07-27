//
//  HomeViewController.m
//  Smart Wash
//
//  Created by Mallikarjuna on 22/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)logoutAction:(id)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:APP_NAME message:@"Would you want to Logout?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                NSLog(@"Cancel");
            }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"OK");
        [[GIDSignIn sharedInstance] signOut];
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated: YES completion: nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

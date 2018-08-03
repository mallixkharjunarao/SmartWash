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
#import "MyProfileViewController.h"
#import "FeedbackViewController.h"
#import "CustomerCareViewController.h"
#import "ITRLeftMenuController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btn_schedulepickup.layer.cornerRadius = 5.0f;
    [_btn_schedulepickup setClipsToBounds:YES];
    
    _btn_feedback.layer.cornerRadius = 5.0f;
    [_btn_feedback setClipsToBounds:YES];
    _btn_myorders.layer.cornerRadius = 5.0f;
    [_btn_myorders setClipsToBounds:YES];
    _btn_ratecard.layer.cornerRadius = 5.0f;
    [_btn_ratecard setClipsToBounds:YES];
    _btn_customercare.layer.cornerRadius = 5.0f;
    [_btn_customercare setClipsToBounds:YES];
    _btn_storelocator.layer.cornerRadius = 5.0f;
    [_btn_storelocator setClipsToBounds:YES];
    _btn_myprofile.layer.cornerRadius = 5.0f;
    [_btn_myprofile setClipsToBounds:YES];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = TRUE;
}

+ (instancetype) controller{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"homeview"];
}

-(IBAction)myprofileaction:(id)sender{
    MyProfileViewController *Forgotpassword = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
    [self.navigationController pushViewController:Forgotpassword animated:YES];
}

-(IBAction)feedbackaction:(id)sender{
    FeedbackViewController *feedbackView = [self.storyboard instantiateViewControllerWithIdentifier:@"feedbackview"];
    [self.navigationController pushViewController:feedbackView animated:YES];
}

-(IBAction)customercareaction:(id)sender{
    CustomerCareViewController *customercareView = [self.storyboard instantiateViewControllerWithIdentifier:@"customercareview"];
    [self.navigationController pushViewController:customercareView animated:YES];
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
        ViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"viewcontrol"];
        [self.navigationController popToViewController:viewController animated:YES];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated: YES completion: nil];
}

-(IBAction)menuButtonaction:(id)sender{
    //show left menu with animation
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    [itrSideMenu presentLeftMenuViewController];
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

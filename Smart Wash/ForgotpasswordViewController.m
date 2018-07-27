//
//  ForgotpasswordViewController.m
//  Smart Wash
//
//  Created by Mallikarjuna on 21/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import "ForgotpasswordViewController.h"
#import "SVProgressHUD.h"
#import "HomeViewController.h"

@interface ForgotpasswordViewController ()

@end

@implementation ForgotpasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tfd_otpnumber.leftView = paddingView;
    _Tfd_otpnumber.leftViewMode = UITextFieldViewModeAlways;
    
    _Tfd_otpnumber.placeholder = @"Enter OTP";
    _Tfd_otpnumber.textColor=[UIColor blackColor];
    _Tfd_otpnumber.delegate=self;
    
    _Vw_OtpPassword.layer.borderWidth = 1.5f;
    _Vw_OtpPassword.layer.cornerRadius = 5.0f;
    [_Vw_OtpPassword setClipsToBounds:YES];
   
    _Vw_OtpPassword.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    self.Btn_Submit.layer.cornerRadius = self.Btn_Submit.frame.size.height/2;
    [self.Btn_Submit setClipsToBounds:YES];
    // Do any additional setup after loading the view.
}


-(BOOL)checkValidations
{
    if (self.Tfd_otpnumber.text.length==0)
    {
        NSString *errorMessage = NSLocalizedString(@"Please Enter your OTP Number", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return FALSE;
    }
    
    return TRUE;
}


-(void)showErrorAlert:(NSString *)errorString
{
    if (errorString!=nil)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:APP_NAME message:errorString preferredStyle:UIAlertControllerStyleAlert];
        //        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        //            NSLog(@"Cancel");
        //        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            NSLog(@"OK");
        }];
        
        //        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated: YES completion: nil];
    }
    return;
}

-(IBAction)otpSubmitAction:(id)sender{
    
    [SVProgressHUD show];
    if ([self checkValidations]) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSArray *details = [[NSArray alloc] initWithObjects:[ud valueForKey:@"user_id"],self.Tfd_otpnumber.text,nil];
        [[ApiManager sharedManager] checkOTPWithDetails:details success:^(NSURLSessionTask *peration, id responseObject) {
            NSMutableDictionary *json = responseObject;
            NSLog(@"check otp response = %@",json);
            NSString *status_forget = [json valueForKey:@"status"];
            if ([status_forget isEqualToString:@"valid"]) {
                [SVProgressHUD dismiss];
                HomeViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"homeview"];
                [self.navigationController pushViewController:viewController animated:true];
            }else{
                [SVProgressHUD dismiss];
                [self showErrorAlert:status_forget];
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"%@",error.localizedDescription);
            [SVProgressHUD dismiss];
            [self showErrorAlert:error.localizedDescription];
        }];
    }
}

-(IBAction)backButtonAction:(id)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        [self.Tfd_otpnumber resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField *nextResponder = (UITextField *)[self.view viewWithTag:textField.tag+1];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }
    if ([_Tfd_otpnumber isFirstResponder]) {
        [self.Tfd_otpnumber setFont:nil];
    }
    
    [textField resignFirstResponder];
    return YES;
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

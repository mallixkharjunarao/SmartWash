//
//  ViewController.m
//  Smart Wash
//
//  Created by Mallikarjuna on 18/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SecondViewController.h"
#import "ForgotpasswordViewController.h"
#import "Strings.h"
#import "HomeViewController.h"
#import "SVProgressHUD.h"
#import "VoxReachabilityManager.h"
#import "ITRLeftMenuController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self SetUifunctionalities];
    
    // TODO(developer) Configure the sign-in button look/feel
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    // Uncomment to automatically sign in the user.
   // [[GIDSignIn sharedInstance] signInSilently];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeProfileChange:) name:FBSDKProfileDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observeTokenChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
    // If there's already a cached token, read the profile information.
    if ([FBSDKAccessToken currentAccessToken]) {
        [self observeProfileChange:nil];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(googleplusredirect:) name:@"googleplus_login" object:nil];


}

-(void)googleplusredirect:(NSNotification*)notification{
    
    NSString *result = notification.object;
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:result,@"id", nil];
    [self socialLogin:dic];
}


#pragma mark - Keyboard events
- (void)keyboardWillShow:(NSNotification*)aNotification
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, - KEYBORADSHOWYPOS, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField *nextResponder = (UITextField *)[self.view viewWithTag:textField.tag+1];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }
    if ([_Tf_Password isFirstResponder]) {
        [self.Tf_Mobilenumber setFont:nil];
    }
    
    [textField resignFirstResponder];
    return YES;
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = TRUE;
}

-(void)SetUifunctionalities{
    self.navigationController.navigationBarHidden = TRUE;
    
    _Tf_Mobilenumber.placeholder = @"MOBILE NUMBER";
    _Tf_Password.placeholder = @"PASSWORD";
    _Tf_Password.textColor=[UIColor blackColor];
    _Tf_Mobilenumber.textColor=[UIColor blackColor];
    
    _Tf_Mobilenumber.delegate = self;
    _Tf_Password.delegate = self;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tf_Mobilenumber.leftView = paddingView;
    _Tf_Mobilenumber.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tf_Password.leftView = paddingView1;
    _Tf_Password.leftViewMode = UITextFieldViewModeAlways;
    
    _Vw_Mobile.layer.borderWidth = 1.5f;
    _Vw_Password.layer.borderWidth = 1.5f;
    _Vw_Mobile.layer.cornerRadius = 5.0f;
    _Vw_Password.layer.cornerRadius = 5.0f;
    [_Vw_Mobile setClipsToBounds:YES];
    [_Vw_Password setClipsToBounds:YES];
    _Vw_Password.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    _Vw_Mobile.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    
    self.Btn_Login.layer.cornerRadius = self.Btn_Login.frame.size.height/2;
    [self.Btn_Login setClipsToBounds:YES];
    
    self.Btn_Google.layer.cornerRadius = self.Btn_Google.frame.size.height/2;
    [self.Btn_Google setClipsToBounds:YES];
    self.Btn_Facebook.layer.cornerRadius = self.Btn_Facebook.frame.size.height/2;
    [self.Btn_Facebook setClipsToBounds:YES];
    
}


-(IBAction)Signupaction:(id)sender{
    SecondViewController *second = [self.storyboard instantiateViewControllerWithIdentifier:@"secondview"];
    [self.navigationController pushViewController:second animated:true];
}

-(IBAction)ForgotPasswordaction:(id)sender{
    
    [SVProgressHUD show];
    if ([self checkforgotValidations]) {
        NSArray *details = [[NSArray alloc] initWithObjects:self.Tf_Mobilenumber.text, nil];
        [[ApiManager sharedManager] forgotWithDetails:details success:^(NSURLSessionTask *peration, id responseObject) {
            NSMutableDictionary *json = responseObject;
            NSLog(@"forget password response = %@",json);
            NSString *status_forget = [json valueForKey:@"status"];
            if ([status_forget isEqualToString:@"valid"]) {
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setValue:self.Tf_Mobilenumber.text forKey:@"user_id"];
                [ud synchronize];
                [SVProgressHUD dismiss];
                ForgotpasswordViewController *Forgotpassword = [self.storyboard instantiateViewControllerWithIdentifier:@"Forgotpassword"];
                [self.navigationController pushViewController:Forgotpassword animated:true];
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

// Implement these methods only if the GIDSignInUIDelegate is not a subclass of
// UIViewController.

// Stop the UIActivityIndicatorView animation that was started when the user
// pressed the Sign In button
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
   // [myActivityIndicator stopAnimating];
    [SVProgressHUD dismiss];
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapSignOut:(id)sender {
    [[GIDSignIn sharedInstance] signOut];
}

#pragma mark - Observations

- (void)observeProfileChange:(NSNotification *)notfication {
    if ([FBSDKProfile currentProfile]) {
        NSString *title = [NSString stringWithFormat:@"continue as %@", [FBSDKProfile currentProfile].name];
        NSLog(@"User details Current=%@",[FBSDKProfile currentProfile].name);
        NSLog(@"User details Current=%@",[FBSDKProfile currentProfile].firstName);
        NSLog(@"User details Current=%@",[FBSDKProfile currentProfile].lastName);
        // NSLog(@"User details Current=%@",[FBSDKProfile currentProfile].facebookId);
        NSLog(@"User details Current=%@",[FBSDKProfile currentProfile].name);
        //  [self.continueButton setTitle:title forState:UIControlStateNormal];
    }
}

- (void)observeTokenChange:(NSNotification *)notfication {
    if (![FBSDKAccessToken currentAccessToken]) {
        //[self.continueButton setTitle:@"continue as a guest" forState:UIControlStateNormal];
    } else {
        [self observeProfileChange:nil];
    }
}



#pragma mark Checking UITextField Validations...
-(BOOL)checkforgotValidations
{
    NSString *errorMessage = nil;
    NSString *str=self.Tf_Mobilenumber.text;
    str= [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"@" withString:@""];
    self.Tf_Mobilenumber.text = str;
    
    if (self.Tf_Mobilenumber.text.length==0)
    {
        errorMessage = NSLocalizedString(@"Please Enter your Mobile Number", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return FALSE;
    }
    else if (self.Tf_Mobilenumber.text.length<=8)
    {
        errorMessage = NSLocalizedString(@"Please Enter Correct Mobile Number", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return FALSE;
    }
    else if (![[VoxReachabilityManager voxReachability] isNetworkReachable])
    {
        errorMessage = NSLocalizedString(INTERNETMESSAGE, nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return FALSE;
    }
    
    return TRUE;
}

#pragma mark Checking UITextField Validations...
-(BOOL)checkValidations
{
    NSString *errorMessage = nil;
    NSString *str=self.Tf_Mobilenumber.text;
    str= [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"@" withString:@""];
    self.Tf_Mobilenumber.text = str;
    
    if (self.Tf_Mobilenumber.text.length==0)
    {
        errorMessage = NSLocalizedString(@"Please Enter your Mobile Number", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return FALSE;
    }
    else if (self.Tf_Mobilenumber.text.length<=8)
    {
        errorMessage = NSLocalizedString(@"Please Enter Correct Mobile Number", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return FALSE;
    }
    else if (self.Tf_Password.text.length==0)
    {
        errorMessage = NSLocalizedString(@"Please Enter your Password", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        
        return FALSE;
    }
    else if (![[VoxReachabilityManager voxReachability] isNetworkReachable])
    {
        errorMessage = NSLocalizedString(INTERNETMESSAGE, nil);
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

-(IBAction)loginBtnAction:(id)sender{
    
    [SVProgressHUD show];
    
    self.Tf_Mobilenumber.text = @"919666949789";
    self.Tf_Password.text=@"123456";
    
    if([self checkValidations]) {
        
    NSArray *details = [[NSArray alloc] initWithObjects:self.Tf_Mobilenumber.text,self.Tf_Password.text, nil];
    [[ApiManager sharedManager] loginWithDetails:details success:^(NSURLSessionTask *operation, id responseObject) {
        
        NSMutableDictionary *json = responseObject;
        NSLog(@"login response = %@",json);
        NSString *token = (NSString *)[json valueForKey:@"Email"];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setValue:token forKey:@"email_id"];
        [ud setValue:[json valueForKey:@"User_id"] forKey:@"user_id"];
        [ud setValue:[json valueForKey:@"User_Name"] forKey:@"User_Name"];
        [ud setValue:[json valueForKey:@"User_id"] forKey:@"user_id"];
        [ud synchronize];
        NSString *status_login = (NSString *)[json valueForKey:@"status"];
        [SVProgressHUD dismiss];
        if ([status_login isEqualToString:@"valid"]) {
            HomeViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"homeview"];
            [self.navigationController pushViewController:viewController animated:true];
        }else{
        [self showErrorAlert:status_login];
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        [SVProgressHUD dismiss];
        [self showErrorAlert:error.localizedDescription];
    }];
    
    }
}



-(IBAction)facebookLogin:(id)sender{
    
    if (![[VoxReachabilityManager voxReachability] isNetworkReachable])
    {
        NSString *errorMessage = NSLocalizedString(INTERNETMESSAGE, nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return;
    }
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        [SVProgressHUD show];
        [self fetchUserInfo];
        if (error) {
            // Process error
            [self facebookLoginFailed:YES];
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"result cancelled=%@",result);
            [self facebookLoginFailed:NO];
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                // Do work
                NSLog(@"result accepted permissions=%@",result);
            }
        }
    }];
}

-(IBAction)googleplusLogin:(id)sender{
    
    [SVProgressHUD show];

    if (![[VoxReachabilityManager voxReachability] isNetworkReachable])
    {
        NSString *errorMessage = NSLocalizedString(INTERNETMESSAGE, nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return;
    }
    
    [[GIDSignIn sharedInstance] signIn];
}

- (void)facebookLoginFailed:(BOOL)isFBResponce{
    if(isFBResponce){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"pop_attention", nil) message:NSLocalizedString(@"request_error", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"pop_ok", nil) otherButtonTitles: nil];
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"pop_attention", nil) message:NSLocalizedString(@"loginfb_cancelled", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"pop_ok", nil) otherButtonTitles: nil];
        [alert show];
    }
}

-(void)fetchUserInfo
{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
             [self socialLogin:result];
         }
     }];
}

-(void)socialLogin:(id)response{
    
        NSArray *details = [[NSArray alloc] initWithObjects:[response valueForKey:@"id"], nil];
        [[ApiManager sharedManager] socialSignUpWithDetails:details success:^(NSURLSessionTask *peration, id responseObject) {
            NSMutableDictionary *json = responseObject;
            NSLog(@"Social Login response = %@",json);
            [SVProgressHUD dismiss];
            HomeViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"homeview"];
            [self.navigationController pushViewController:viewController animated:true];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"%@",error.localizedDescription);
            [SVProgressHUD dismiss];
        }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        [self.Tf_Mobilenumber resignFirstResponder];
        [self.Tf_Password resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

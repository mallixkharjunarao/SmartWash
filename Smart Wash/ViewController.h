//
//  ViewController.h
//  Smart Wash
//
//  Created by Mallikarjuna on 18/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "ITRAirSideMenu.h"


@interface ViewController : UIViewController<GIDSignInUIDelegate, UITextFieldDelegate>

@property(nonatomic,weak) IBOutlet UITextField *Tf_Mobilenumber;
@property(nonatomic,weak) IBOutlet UITextField *Tf_Password;
@property(nonatomic,weak) IBOutlet UIView *Vw_Mobile;
@property(nonatomic,weak) IBOutlet UIView *Vw_Password;
@property(nonatomic,weak) IBOutlet UIButton *Btn_Login;
@property(nonatomic,weak) IBOutlet UIButton *Btn_Facebook;
@property(nonatomic,weak) IBOutlet UIButton *Btn_Google;

-(IBAction)Signupaction:(id)sender;
-(IBAction)ForgotPasswordaction:(id)sender;

-(IBAction)facebookLogin:(id)sender;

-(IBAction)googleplusLogin:(id)sender;

-(IBAction)loginBtnAction:(id)sender;

-(IBAction)signupBtnAction:(id)sender;


@end


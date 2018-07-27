//
//  ForgotpasswordViewController.h
//  Smart Wash
//
//  Created by Mallikarjuna on 21/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"

@interface ForgotpasswordViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,weak) IBOutlet UIView *Vw_OtpPassword;
@property(nonatomic,weak) IBOutlet UITextField *Tfd_otpnumber;
@property(nonatomic,weak) IBOutlet UIButton *Btn_Submit;

-(IBAction)otpSubmitAction:(id)sender;
-(IBAction)backButtonAction:(id)sender;


@end

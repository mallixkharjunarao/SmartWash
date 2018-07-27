//
//  SecondViewController.h
//  Smart Wash
//
//  Created by Mallikarjuna on 21/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "MLTableAlert.h"


@interface SecondViewController : UIViewController<UITextFieldDelegate>
-(IBAction)loginAction:(id)sender;
-(IBAction)signupAction:(id)sender;
-(IBAction)locationselectAction:(id)sender;
-(IBAction)BackAction:(id)sender;


@property(nonatomic,weak) IBOutlet UIButton *Btn_Schedulepickup;
@property(nonatomic,weak) IBOutlet UIButton *Btn_Placeorder;
@property (strong, nonatomic) MLTableAlert *tableAlert;
@property(strong,nonatomic) NSMutableArray *arrayName, *arrayIds;


@property(nonatomic,weak) IBOutlet UITextField *Tfd_Username;
@property(nonatomic,weak) IBOutlet UITextField *Tfd_Password;
@property(nonatomic,weak) IBOutlet UITextField *Tfd_Mobilenumber;
@property(nonatomic,weak) IBOutlet UITextField *Tfd_Emailid;
@property(nonatomic,weak) IBOutlet UITextField *Tfd_address_text;
@property(nonatomic,weak) IBOutlet UITextView *Tfd_Adress;
@property(nonatomic,weak) IBOutlet UIButton *Btn_Location;

@property(nonatomic,weak) IBOutlet UIView *Vw_Username;
@property(nonatomic,weak) IBOutlet UIView *Vw_Password;
@property(nonatomic,weak) IBOutlet UIView *Vw_Mobilenumber;
@property(nonatomic,weak) IBOutlet UIView *Vw_Emailid;
@property(nonatomic,weak) IBOutlet UIView *Vw_Adress;
@end

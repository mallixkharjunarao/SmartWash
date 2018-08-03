//
//  MyProfileViewController.h
//  Smart Wash
//
//  Created by rahul on 24/07/18.
//  Copyright © 2018 rahul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileViewController : UIViewController<UITextViewDelegate>
@property(nonatomic,weak) IBOutlet UIButton *Btn_Login;
@property(nonatomic,weak) IBOutlet UITextField *Tf_Mobilenumber;
@property(nonatomic,weak) IBOutlet UITextField *Tf_Email;
@property (weak, nonatomic) IBOutlet UITextField *Tf_address;
@property(nonatomic,weak) IBOutlet UITextView *Tw_address;
@property (weak, nonatomic) IBOutlet UITextField *Tf_location;
@property(nonatomic,weak) IBOutlet UIButton *btn_location;

@property(nonatomic,weak) IBOutlet UIView *Vw_Mobile;
@property(nonatomic,weak) IBOutlet UIView *Vw_Email;
@property(nonatomic,weak) IBOutlet UIView *Vw_Address;
@property(nonatomic,weak) IBOutlet UIView *Vw_Location;

@property(nonatomic,weak) IBOutlet UIButton *btn_camera;
@property(nonatomic,weak) IBOutlet UIImageView *profileimageview;

-(IBAction)menuButtonAction:(id)sender;

+ (instancetype) controller;


@end

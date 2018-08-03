//
//  HomeViewController.h
//  Smart Wash
//
//  Created by Mallikarjuna on 22/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITRAirSideMenu.h"

@interface HomeViewController : UIViewController

@property ITRAirSideMenu *itrAirSideMenu;
@property(nonatomic,weak) IBOutlet UIButton *btn_schedulepickup;
@property(nonatomic,weak) IBOutlet UIButton *btn_myprofile;
@property(nonatomic,weak) IBOutlet UIButton *btn_myorders;
@property(nonatomic,weak) IBOutlet UIButton *btn_ratecard;
@property(nonatomic,weak) IBOutlet UIButton *btn_storelocator;
@property(nonatomic,weak) IBOutlet UIButton *btn_feedback;
@property(nonatomic,weak) IBOutlet UIButton *btn_customercare;

-(IBAction)menuButtonaction:(id)sender;
-(IBAction)logoutAction:(id)sender;

-(IBAction)myprofileaction:(id)sender;
-(IBAction)feedbackaction:(id)sender;
-(IBAction)customercareaction:(id)sender;

+ (instancetype)controller;

@end

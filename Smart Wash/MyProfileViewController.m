//
//  MyProfileViewController.m
//  Smart Wash
//
//  Created by rahul on 24/07/18.
//  Copyright © 2018 rahul. All rights reserved.
//

#import "MyProfileViewController.h"
#import "ITRAirSideMenu.h"
#import "AppDelegate.h"
#import "Strings.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

+ (instancetype) controller{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MyProfileViewController class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _profileimageview.layer.cornerRadius = _profileimageview.frame.size.height/2;
    [_profileimageview setClipsToBounds:YES];
    _profileimageview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _profileimageview.layer.borderWidth = 2.0f;

    _btn_camera.layer.cornerRadius = _btn_camera.frame.size.height/2;
    [_btn_camera setClipsToBounds:YES];
    
    _Tf_Mobilenumber.placeholder = @"ADDRESS";
    _Tf_Email.textColor=[UIColor blackColor];
    _Tf_Mobilenumber.textColor=[UIColor blackColor];
    _Tw_address.textColor=[UIColor blackColor];
    _Tw_address.delegate = self;
    
    _Tf_Mobilenumber.text = @"9666949789";
    _Tf_Email.text = @"mdevasai@gmail.com";
   // _Tw_address.text = @"Hyderabad";
    _Tf_address.placeholder = @"Address";
    _Tf_location.placeholder = @"Select Location";

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tf_Mobilenumber.leftView = paddingView;
    _Tf_Mobilenumber.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tf_Email.leftView = paddingView1;
    _Tf_Email.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tf_address.leftView = paddingView2;
    _Tf_address.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tf_location.leftView = paddingView3;
    _Tf_location.leftViewMode = UITextFieldViewModeAlways;
    
    _Vw_Mobile.layer.borderWidth = 1.5f;
    _Vw_Email.layer.borderWidth = 1.5f;
    _Vw_Location.layer.borderWidth = 1.5f;
    _Vw_Address.layer.borderWidth = 1.5f;
    
    _Vw_Mobile.layer.cornerRadius = 5.0f;
    _Vw_Email.layer.cornerRadius = 5.0f;
    _Vw_Location.layer.cornerRadius = 5.0f;
    _Vw_Address.layer.cornerRadius = 5.0f;

    [_Vw_Mobile setClipsToBounds:YES];
    [_Vw_Email setClipsToBounds:YES];
    [_Vw_Location setClipsToBounds:YES];
    [_Vw_Address setClipsToBounds:YES];

    
    _Vw_Address.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    _Vw_Mobile.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    
    _Vw_Location.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    _Vw_Email.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.Btn_Login.layer.cornerRadius = self.Btn_Login.frame.size.height/2;
    [self.Btn_Login setClipsToBounds:YES];
    // Do any additional setup after loading the view.
}

-(IBAction)menuButtonAction:(id)sender{
    
    //show left menu with animation
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    [itrSideMenu presentLeftMenuViewController];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = TRUE;
}


- (BOOL)textViewShouldReturn:(UITextView *)textField {
    [self.Tf_address resignFirstResponder];
    return YES;
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

-(void)textViewDidBeginEditing:(UITextView *)textField {

    if ([_Tf_address.text isEqualToString:@"Address"]) {
        _Tf_address.text = @"";
    }
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
////    if ([text isEqualToString:@"\n"]) {
////        NSLog(@"Return pressed, do whatever you like here");
////        return NO; // or true, whetever you's like
////    }
//    
//    if ([_Tw_address.text isEqualToString:@""]) {
//        _Tf_address.hidden = NO;
//    }else{
//    _Tf_address.hidden = YES;
//    }
//    
//    return YES;
//}

//- (void)textViewDidEndEditing:(UITextView *)textField {
//    if ([_Tf_address.text isEqualToString:@""]) {
//        _Tf_address.text = @"Address";
//    }
//}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        _Tf_address.hidden = NO;
    }else{
        _Tf_address.hidden = YES;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        [self.view endEditing:YES];
    }
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

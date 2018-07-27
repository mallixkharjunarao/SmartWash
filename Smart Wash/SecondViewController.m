//
//  SecondViewController.m
//  Smart Wash
//
//  Created by Mallikarjuna on 21/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import "SecondViewController.h"
#import "SVProgressHUD.h"
#import "VoxReachabilityManager.h"
#import "HomeViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize arrayName,arrayIds;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayName=[[NSMutableArray alloc] initWithObjects:@"gvp",@"Madhapur",nil];
    arrayIds =[[NSMutableArray alloc] initWithObjects:@"0",@"1",nil];
    
    _Tfd_Username.placeholder = @"USER NAME";
    _Tfd_Password.placeholder = @"PASSWORD";
    _Tfd_Mobilenumber.placeholder = @"MOBILE NUMBER";
    _Tfd_Emailid.placeholder = @"EMAIL ID";
    
    _Tfd_Username.textColor=[UIColor blackColor];
    _Tfd_Password.textColor=[UIColor blackColor];
    _Tfd_Mobilenumber.textColor=[UIColor blackColor];
    _Tfd_Emailid.textColor=[UIColor blackColor];
    _Tfd_Adress.textColor=[UIColor blackColor];
    
    _Tfd_Username.delegate = self;
    _Tfd_Password.delegate = self;
    _Tfd_Mobilenumber.delegate = self;
    _Tfd_Emailid.delegate = self;
    

    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tfd_Username.leftView = paddingView;
    _Tfd_Username.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tfd_Password.leftView = paddingView1;
    _Tfd_Password.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tfd_Mobilenumber.leftView = paddingView2;
    _Tfd_Mobilenumber.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 20)];
    _Tfd_Emailid.leftView = paddingView3;
    _Tfd_Emailid.leftViewMode = UITextFieldViewModeAlways;
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _Tfd_Username.layer.borderWidth = 1.5f;
    _Tfd_Mobilenumber.layer.borderWidth = 1.5f;
    _Tfd_Password.layer.borderWidth = 1.5f;
    _Tfd_Adress.layer.borderWidth = 1.5f;
    _Tfd_Emailid.layer.borderWidth = 1.5f;
    _Btn_Location.layer.borderWidth = 1.5f;
    
    _Tfd_Emailid.layer.cornerRadius = 5.0f;
    _Tfd_Mobilenumber.layer.cornerRadius = 5.0f;
    _Tfd_Adress.layer.cornerRadius = 5.0f;
    
    _Tfd_Username.layer.cornerRadius = 5.0f;
    _Tfd_Password.layer.cornerRadius = 5.0f;
    _Btn_Location.layer.cornerRadius = 5.0f;

    
    [_Tfd_Emailid setClipsToBounds:YES];
    [_Tfd_Mobilenumber setClipsToBounds:YES];
    [_Tfd_Adress setClipsToBounds:YES];
    [_Tfd_Username setClipsToBounds:YES];
    [_Tfd_Password setClipsToBounds:YES];
    [_Btn_Location setClipsToBounds:YES];

    
    
    _Tfd_Emailid.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    _Tfd_Mobilenumber.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
      _Tfd_Adress.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    _Tfd_Password.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    _Tfd_Username.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
      _Btn_Location.layer.borderColor = [UIColor colorWithRed:149.0f/255.0f green:146.0f/255.0f blue:154.0f/255.0f alpha:1.0f].CGColor;
    
    _Btn_Schedulepickup.layer.cornerRadius = 5;
    [_Btn_Schedulepickup setClipsToBounds:YES];
    
    _Btn_Placeorder.layer.cornerRadius = 5;
    [_Btn_Placeorder setClipsToBounds:YES];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        [self.view endEditing:YES];
    }
}

#pragma mark - Keyboard events
- (void)keyboardWillShow:(NSNotification*)aNotification
{
    if (_Tfd_Mobilenumber.text) {
        self.view.frame = CGRectMake(self.view.frame.origin.x, - KEYBORADSHOWYPOS, self.view.frame.size.width, self.view.frame.size.height);
    }
}

- (void)keyboardWillHide:(NSNotification*)aNotification
{
    if (_Tfd_Mobilenumber.text) {
    self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _Tfd_Username) {
        [textField resignFirstResponder];
        [_Tfd_Password becomeFirstResponder];
    }
    else if (textField == _Tfd_Password) {
        [textField resignFirstResponder];
        [_Tfd_Mobilenumber becomeFirstResponder];
    }
    else if (textField == _Tfd_Mobilenumber) {
        [textField resignFirstResponder];
        [_Tfd_Emailid becomeFirstResponder];
    }
    else if (textField == _Tfd_Emailid) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)loginAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated: YES completion: nil];
    }
    return;
}

#pragma mark Checking UITextField Validations...
-(BOOL)checkValidations
{
    NSString *str=self.Tfd_Mobilenumber.text;
    str= [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"." withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"@" withString:@""];
    self.Tfd_Mobilenumber.text = str;
    
    if (self.Tfd_Username.text.length==0)
    {
        NSString *errorMessage = NSLocalizedString(@"Please Enter Username", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return FALSE;
    }
    else if (self.Tfd_Password.text.length==0)
    {
        NSString *errorMessage = NSLocalizedString(@"Please Enter Passsword", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return FALSE;
    }
    else if (self.Tfd_Mobilenumber.text.length==0)
    {
        NSString *errorMessage = NSLocalizedString(@"Please Enter Mobile number", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        
        return FALSE;
    }
    else if (self.Tfd_Emailid.text.length==0)
    {
        NSString *errorMessage = NSLocalizedString(@"Please Enter Email", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        
        return FALSE;
    }
    else if (self.Tfd_Adress.text.length==0)
    {
        NSString *errorMessage = NSLocalizedString(@"Please Enter Address", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];

        return FALSE;
    }
    else if (self.Btn_Location.titleLabel.text==0)
    {
        NSString *errorMessage = NSLocalizedString(@"Please Select Location", nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        
        return FALSE;
    }
    else if (![[VoxReachabilityManager voxReachability] isNetworkReachable])
    {
        NSString *errorMessage = NSLocalizedString(INTERNETMESSAGE, nil);
        [SVProgressHUD dismiss];
        [self showErrorAlert:errorMessage];
        return FALSE;
    }
    
    return TRUE;
}

-(IBAction)signupAction:(id)sender{
    
    [SVProgressHUD show];
    
    if([self checkValidations]) {
        NSUserDefaults *eventid = [NSUserDefaults standardUserDefaults];
        NSArray *details = [[NSArray alloc] initWithObjects:self.Tfd_Username.text,self.Tfd_Password.text,self.Tfd_Mobilenumber.text,self.Tfd_Emailid.text,self.Tfd_Adress.text,[eventid valueForKey:@"evid"], nil];
        [[ApiManager sharedManager] signupWithDetails:details success:^(NSURLSessionTask *operation, id responseObject) {
            NSMutableDictionary *json = responseObject;
            NSLog(@"json=%@",json);
            [SVProgressHUD dismiss];
            HomeViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"homeview"];
            [self.navigationController pushViewController:viewController animated:true];
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"%@",error.localizedDescription);
            [SVProgressHUD dismiss];
        }];
        
    }
}

-(IBAction)BackAction:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];

}


-(IBAction)locationselectAction:(id)sender{
        NSString *str1, *str2;
        str1=@"Select location";
        str2 = @"Cancel";
        self.tableAlert = [MLTableAlert tableAlertWithTitle:str1 cancelButtonTitle:str2 numberOfRows:^NSInteger (NSInteger section){
            return [arrayName count];
        }  andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                           {
                               static NSString *CellIdentifier = @"CellIdentifier";
                               UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                               if (cell == nil)
                                   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                               cell.textLabel.font=[UIFont fontWithName:@"Arial" size:14];
                               cell.textLabel.text = [NSString stringWithFormat:@"%@", [arrayName objectAtIndex:indexPath.row]];
                               cell.textLabel.textAlignment  =NSTextAlignmentCenter;
                               return cell;
                           }];
        
        self.tableAlert.height = 150;
        
        [self.tableAlert configureSelectionBlock:^(NSIndexPath *selectedIndex)
         {
             
             for (int i=0; i<[arrayName count]; i++) {
                 if (selectedIndex.row==i) {
                     [_Btn_Location setTitle:[NSString stringWithFormat:@"%@", [arrayName objectAtIndex:i]] forState:UIControlStateNormal];
                     [_Btn_Location.titleLabel setTextAlignment:NSTextAlignmentLeft];
                     NSLog(@"array index: %@",[arrayName objectAtIndex:i]);
                     NSLog(@"array index: %@",[arrayIds objectAtIndex:i]);

                     NSUserDefaults *eventid = [NSUserDefaults standardUserDefaults];
                     [eventid setValue:[arrayIds objectAtIndex:i] forKey:@"evid"];
                     [eventid synchronize];
                 }
                 
             }
             
         } andCompletionBlock:^{
         }];
        
        [self.tableAlert show];
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

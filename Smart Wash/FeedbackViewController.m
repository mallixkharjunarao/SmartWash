//
//  FeedbackViewController.m
//  Smart Wash
//
//  Created by Mallikarjuna on 28/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import "FeedbackViewController.h"
#import "ITRAirSideMenu.h"
#import "AppDelegate.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

+ (instancetype) controller{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"feedbackview"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = TRUE;
}

-(IBAction)menuButtonaction:(id)sender{
    //show left menu with animation
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    [itrSideMenu presentLeftMenuViewController];
}

-(IBAction)logoutAction:(id)sender{
    
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

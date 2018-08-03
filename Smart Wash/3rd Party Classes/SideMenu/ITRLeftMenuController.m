//
//  LeftMenuController.m
//  ITRAirSideMenu
//
//  Created by kirthi on 12/08/15.
//  Copyright (c) 2015 kirthi. All rights reserved.
//

#import "ITRLeftMenuController.h"
#import "MyProfileViewController.h"
#import "HomeViewController.h"
#import "FeedbackViewController.h"
#import "CustomerCareViewController.h"
#import "AppDelegate.h"
#import "LeftmenuCell.h"

@interface ITRLeftMenuController ()
{
    NSIndexPath *selectedIndexPath;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ITRLeftMenuController


+ (instancetype)controller {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ITRLeftMenuController class])];
}

#pragma view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    LeftmenuCell *cell = (LeftmenuCell *)[tableView cellForRowAtIndexPath:indexPath];
//    [self setCellColor:[UIColor darkGrayColor] ForCell:cell];  //highlight colour
    
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    //update content view controller with setContentViewController
    [itrSideMenu hideMenuViewController];
    selectedIndexPath = indexPath;
}


#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"leftmenuCell";
    
    // Similar to UITableViewCell, but
    LeftmenuCell *cell = (LeftmenuCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LeftmenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (cell == nil) {
        cell.backgroundColor = [UIColor clearColor];
        cell.leftmenuLabel.font = [UIFont fontWithName:@"Comfortaa-Bold" size:16];
        cell.leftmenuLabel.textColor = [UIColor blackColor];
    }
    
    NSArray *titles = @[@"Home", @"My Profile", @"Orders History", @"Feed Back", @"Customer Care"];
    cell.leftmenuLabel.text = titles[indexPath.row];
    NSArray *images = @[@"icon.png", @"my-profile.png", @"order-history.png", @"feedback.png", @"contact-support"];
    cell.leftmenuImage.image = [UIImage imageNamed:images[indexPath.row]];
    return cell;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(LeftmenuCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIView *view = [[UIView alloc] init];
//    [view setBackgroundColor:[UIColor redColor]];
//    [cell setSelectedBackgroundView:view];
//}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Add your Colour.
    LeftmenuCell *cell = (LeftmenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor darkGrayColor] ForCell:cell];  //highlight colour
}


- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Reset Colour.
    LeftmenuCell *cell = (LeftmenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor clearColor] ForCell:cell]; //normal color
}


- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}

#pragma mark -
#pragma mark ITRAirSideMenu Delegate

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer {
    
    NSLog(@"didRecognizePanGesture");
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController {
    
    NSLog(@"willShowMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController {
    
    NSLog(@"didShowMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController {
    
    NSLog(@"willHideMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController{
    
    NSLog(@"didHideMenuViewController: %@ isMenuVisible <%d>", NSStringFromClass([menuViewController class]), (int)sideMenu.isLeftMenuVisible );
    
    if (selectedIndexPath.row==0) {
        [sideMenu setContentViewController:[[UINavigationController alloc] initWithRootViewController:[HomeViewController controller]]];
        
    }else if (selectedIndexPath.row==1){
        [sideMenu setContentViewController:[[UINavigationController alloc] initWithRootViewController:[MyProfileViewController controller]]];
    }else if (selectedIndexPath.row==2){
        
    }else if (selectedIndexPath.row==3){
        [sideMenu setContentViewController:[[UINavigationController alloc] initWithRootViewController:[FeedbackViewController controller]]];

    }else{
        [sideMenu setContentViewController:[[UINavigationController alloc] initWithRootViewController:[CustomerCareViewController controller]]];

    }
        
}
@end

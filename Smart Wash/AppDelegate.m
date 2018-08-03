//
//  AppDelegate.m
//  Smart Wash
//
//  Created by Mallikarjuna on 18/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "VoxReachabilityManager.h"
#import "ITRLeftMenuController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    [[FBSDKApplicationDelegate sharedInstance] application:application
                                                didFinishLaunchingWithOptions:launchOptions];
    
    [GIDSignIn sharedInstance].clientID = @"712367248236-uhgq4a2vukf54rj8s686363dvm6sndtr.apps.googleusercontent.com";  // @"YOUR_CLIENT_ID"
    [GIDSignIn sharedInstance].delegate = self;
    
    // Register for Reachability Callback Methods---
    [VoxReachabilityManager voxReachability];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //sidemenu created with content view controller & menu view controller

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    UINavigationController *navigationController;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if ([ud valueForKey:@"user_id"]==nil || [[ud valueForKey:@"user_id"] isEqualToString:@"Empty"]){
        navigationController = [[UINavigationController alloc] initWithRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"viewcontrol"]];

    }else{
        navigationController = [[UINavigationController alloc] initWithRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"homeview"]];
    }

    ITRLeftMenuController *leftMenuViewController = [ITRLeftMenuController controller];
    _itrAirSideMenu = [[ITRAirSideMenu alloc] initWithContentViewController:navigationController leftMenuViewController:leftMenuViewController];

   // _itrAirSideMenu.backgroundImage = [UIImage imageNamed:@"menu_bg"];

    //optional delegate to receive menu view status
    _itrAirSideMenu.delegate = leftMenuViewController;

    //content view shadow properties
    _itrAirSideMenu.contentViewShadowColor = [UIColor blackColor];
    _itrAirSideMenu.contentViewShadowOffset = CGSizeMake(0, 0);
    _itrAirSideMenu.contentViewShadowOpacity = 0.6;
    _itrAirSideMenu.contentViewShadowRadius = 12;
    _itrAirSideMenu.contentViewShadowEnabled = YES;

    //content view animation properties
    _itrAirSideMenu.contentViewScaleValue = 0.7f;
    _itrAirSideMenu.contentViewRotatingAngle = 30.0f;
    _itrAirSideMenu.contentViewTranslateX = 130.0f;

    //menu view properties
    _itrAirSideMenu.menuViewRotatingAngle = 30.0f;
    _itrAirSideMenu.menuViewTranslateX = 130.0f;

    self.window.rootViewController = _itrAirSideMenu;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Add any custom logic here.
    return YES;
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options {
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    // ...
    NSMutableArray *googlearray = [[NSMutableArray alloc]initWithObjects:userId,idToken,fullName,givenName,familyName,email, nil];
    NSLog(@"Goggle+ loged in user = %@",googlearray);
     [[NSNotificationCenter defaultCenter]postNotificationName:@"googleplus_login" object:userId userInfo:nil];
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Smart_Wash"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end

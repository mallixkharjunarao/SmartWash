//
//  AppDelegate.h
//  Smart Wash
//
//  Created by Mallikarjuna on 18/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ITRAirSideMenu.h"

@import GoogleSignIn;
@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;
@property ITRAirSideMenu *itrAirSideMenu;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


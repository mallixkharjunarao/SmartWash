//
//  VoxReachabilityManager.h
//  VoxDialer
//
//  Created by GiriPrathapRaju on 09/12/14.
//  Copyright (c) 2014 voxvalley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

#import "AppDelegate.h"
@interface VoxReachabilityManager : NSObject
{
    int internetAlert;
    int count;
    
}
@property (nonatomic,retain) Reachability *internetReachability;
@property (nonatomic,retain) Reachability *hostReachability;
@property (nonatomic,retain) Reachability *wifiReachability;
@property (nonatomic, retain) NSString *statusvalue;
@property (nonatomic, retain) NSString *wrongmsg;
@property(nonatomic,retain) Reachability *reach;

+(VoxReachabilityManager *)voxReachability;

-(void)checkForHostReachablility;
-(void)internetStatus:(NSNotification *)reachability;
-(BOOL)isNetworkReachable;

@end

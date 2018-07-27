//
//  VoxReachabilityManager.m
//  VoxDialer
//
//  Created by GiriPrathapRaju on 09/12/14.
//  Copyright (c) 2014 voxvalley. All rights reserved.
//

#import "VoxReachabilityManager.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

static VoxReachabilityManager *voxReachabilityManagerObj = nil;

@implementation VoxReachabilityManager
@synthesize internetReachability,hostReachability,wifiReachability,reach;

+(VoxReachabilityManager *)voxReachability
{
    if (voxReachabilityManagerObj==nil)
    {
        voxReachabilityManagerObj = [[VoxReachabilityManager alloc] init];
    }
    return voxReachabilityManagerObj;
}

- (instancetype)init
{
     NSLog(@"%s",__func__);
    self = [super init];
    if (self) {
       
        [self checkForHostReachablility];
        count = 0;
        internetAlert=0;
        
        [[NSNotificationCenter defaultCenter]removeObserver:self name:kReachabilityChangedNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(internetStatus:) name:kReachabilityChangedNotification object:nil];
    }
    return self;
}


-(void)checkForHostReachablility
{
     NSLog(@"%s",__func__);
    // Host Reachability Check...
    self.hostReachability = [Reachability reachabilityWithHostName:@"www.google.com"];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
     NSLog(@"%s",__func__);
    if (reachability == self.hostReachability)
    {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL connectionRequired = [reachability connectionRequired];
        
        
        if (connectionRequired)
        {
           NSLog(@"Cellular data network is available.\nInternet traffic will be routed through it after a connection is established.");
        }
        else
        {
            NSLog(@"Cellular data network is active.\nInternet traffic will be routed through it.");
            //[[self appDelegate].xmppStream disconnect];
        }
    }
    
    if (reachability == self.internetReachability)
    {
        NSLog(@"internetReachability block");
    }
    
    if (reachability == self.wifiReachability)
    {
        NSLog(@"wifiReachability block");
    }
}

-(void)dismissCallScreenwhennetworklost
{
     NSLog(@"%s",__func__);
    
}

- (NSString *)getIPAddress

{
    NSString *address = @"error";    struct ifaddrs *interfaces = NULL;   struct ifaddrs *temp_addr = NULL;    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    
    success= getifaddrs(&interfaces);    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL)
            
        {
            if( temp_addr->ifa_addr->sa_family == AF_INET)
                
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                    
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
        
    }
    
    // Free memory   freeifaddrs(interfaces);
    
    return address;
    
}

-(void)internetStatus:(NSNotification *)reachability
{
    NSLog(@"%s",__func__);
    
    self.reach = (Reachability *)[reachability object];
    NetworkStatus netStatus = [self.reach currentReachabilityStatus];
    
    if (netStatus == NotReachable)
    {
        count = 0;
        if (internetAlert==0) {
            internetAlert++;
        }
    }
    else if (netStatus == ReachableViaWiFi)
    {
        
    }
    else if (netStatus == ReachableViaWWAN)
    {
        
    }
    
}


-(BOOL)isNetworkReachable
{
    NSLog(@"%s",__func__);
    
    NetworkStatus netStatus = [self.reach currentReachabilityStatus];
    
    if (netStatus == NotReachable)
    {
        return FALSE;
    }else
    {
        return TRUE;
    }
}

@end

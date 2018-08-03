//
//  ApiManager.h
//  Smart Wash
//
//  Created by Mallikarjuna on 19/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"

@interface ApiManager : NSObject

+ (ApiManager*)sharedManager;
+ (AFHTTPSessionManager*)sessionManager;
- (instancetype)init;
- (NSString*)jsonStringWithJsonDict:(NSDictionary*)jsonDict;

//For Login Api
- (void)loginWithDetails:(NSArray *)details
                 success:(void (^)(NSURLSessionTask *operation, id responseObject))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;


//For SignUp Api
- (void)signupWithDetails:(NSArray *)details
                  success:(void (^)(NSURLSessionTask *peration, id responseObject))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//For Social SignUp/SignIn Api
- (void)socialSignUpWithDetails:(NSArray *)details
                        success:(void (^)(NSURLSessionTask *peration, id responseObject))success
                        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//For Forgot Api
- (void)forgotWithDetails:(NSArray *)details
                  success:(void (^)(NSURLSessionTask *peration, id responseObject))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//For CheckOTP Api
- (void)checkOTPWithDetails:(NSArray *)details
                    success:(void (^)(NSURLSessionTask *peration, id responseObject))success
                    failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

// For Signup locations Api
- (void)signupLocationWithDetails:(NSArray *)details
                    success:(void (^)(NSURLSessionTask *peration, id responseObject))success
                    failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

@end

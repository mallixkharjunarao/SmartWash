//
//  ApiManager.m
//  Smart Wash
//
//  Created by Mallikarjuna on 19/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#import "ApiManager.h"

@implementation ApiManager

+ (ApiManager*)sharedManager {
    
    static ApiManager* _sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

+ (AFHTTPSessionManager*)sessionManager {
    
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",SmartWashBaseURL]];
    AFHTTPSessionManager* sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/html",@"text/javascript",@"application/x-www-form-urlencoded", nil]];
    
    return sessionManager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        //self.deviceTokenId = @"";
    }
    return self;
}

- (NSString*)jsonStringWithJsonDict:(NSDictionary*)jsonDict {
    NSString* jsonString = @"";
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    if (jsonData)
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

//For Login Api
- (void)loginWithDetails:(NSArray *)details
                 success:(void (^)(NSURLSessionTask *operation, id responseObject))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    
    NSDictionary* dataDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                             [details objectAtIndex:0],loginApimobilenumber,
                             [details objectAtIndex:1],loginApiPassword, nil];
    
    AFHTTPSessionManager *sessionManager = [[self class] sessionManager];
    [sessionManager POST:loginURL parameters:dataDict progress:nil success:success failure:failure];
}


// For SignUp/SignIn Api
- (void)signupWithDetails:(NSArray *)details
                  success:(void (^)(NSURLSessionTask *peration, id responseObject))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* dataDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                             [details objectAtIndex:0],registerApiusername,
                             [details objectAtIndex:1],registerApiPassword,
                             [details objectAtIndex:2],registerApimobile,
                             [details objectAtIndex:3],registerApiemail,
                             [details objectAtIndex:4],registerApiaddress,
                             [details objectAtIndex:5],registerApilocationid,
                             nil];
    
    AFHTTPSessionManager *sessionManager = [[self class] sessionManager];
    [sessionManager POST:signupURL parameters:dataDict progress:nil success:success failure:failure];
    
}

//For Social SignUp/Login URL Api
- (void)socialSignUpWithDetails:(NSArray*)details
                        success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* dataDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                             [details objectAtIndex:0],socialID,
                             nil];
    AFHTTPSessionManager* operationManager = [[self class] sessionManager];
    [operationManager POST:socialURL parameters:dataDict progress:nil success:success failure:failure];
}

//For Forgot Api
- (void)forgotWithDetails:(NSArray *)details
                  success:(void (^)(NSURLSessionTask *peration, id responseObject))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary* dataDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                             [details objectAtIndex:0],loginApimobilenumber,nil];
    AFHTTPSessionManager* operationManager = [[self class] sessionManager];
    [operationManager POST:forgetOTPURL parameters:dataDict progress:nil success:success failure:failure];
}

//For CheckOTP Api
- (void)checkOTPWithDetails:(NSArray *)details
                  success:(void (^)(NSURLSessionTask *peration, id responseObject))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure{
    NSDictionary* dataDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                             [details objectAtIndex:0],checkOTPMobileNumber,
                             [details objectAtIndex:1],checkOTP,
                             nil];
    AFHTTPSessionManager* operationManager = [[self class] sessionManager];
    [operationManager POST:checkOTPURL parameters:dataDict progress:nil success:success failure:failure];
}

@end

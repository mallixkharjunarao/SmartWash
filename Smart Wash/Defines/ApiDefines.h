//
//  ApiDefines.h
//  Smart Wash
//
//  Created by Mallikarjuna on 18/07/18.
//  Copyright © 2018 Mallikarjuna. All rights reserved.
//

#ifndef ApiDefines_h
#define ApiDefines_h


#define SmartWashBaseURL @"https://gotechworld.com/smart/api/apk.php"

//login Screen - file (loginViewController)
#define loginURL @"?rquest=Check_login"
//params
#define loginApimobilenumber  @"mobile"
#define loginApiPassword  @"password"


//Register Screen - file (RegisterViewController)
#define signupURL @"?rquest=register"
//params
#define registerApiusername  @"username"
#define registerApiPassword  @"password"
#define registerApimobile  @"mobile"
#define registerApiemail  @"email"
#define registerApiaddress  @"address"
#define registerApilocationid  @"location_id"

// Forget OTP - file  (ForgetpasswordViewController)
#define forgetOTPURL   @"?rquest=forget_otp"
//params
#define forgetMobileNumber @"mobile"

//Check OTP - file (CheckOTPView)
#define checkOTPURL    @"?rquest=check_otp"
//params
#define checkOTPMobileNumber @"mobile"
#define checkOTP             @"otp"

//Social Login - file (Facebook/Google+ Login View)
#define socialURL    @"?rquest=Fb_Check_login"
//params
#define socialID             @"fb_id"

//signup location - file (RegisterViewController)
#define signupLocationURL    @"?rquest=locations"

#endif /* ApiDefines_h */

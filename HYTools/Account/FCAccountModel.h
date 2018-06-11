//
//  FCAccountModel.h
//  EDFMerchant
//
//  Created by Hoo on 2018/5/19.
//  Copyright © 2018年 EDF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCAccountModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *storeid;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *sname;
@property (nonatomic, copy) NSString *groupid;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *sid;


@property (nonatomic, copy) NSString *access_token;

+ (instancetype)sharedModel;

+ (void)configInfo:(NSDictionary *)dict;

+ (void)loginOut;


@end

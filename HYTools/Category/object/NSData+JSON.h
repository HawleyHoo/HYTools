//
//  NSData+JSON.h
//  HYTools
//
//  Created by Hoo on 2018/6/6.
//  Copyright © 2018年 net.fitcome.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JSON)


@property (nonatomic, strong, readonly) NSDictionary *dictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary *dictionaryOfRemovedESC;
@property (nonatomic, strong, readonly) NSString *stringOfRemovedESC;
@property (nonatomic, strong, readonly) NSString *bluetoothStringOfRemovedESC;

@end

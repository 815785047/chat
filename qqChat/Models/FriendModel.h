//
//  FriendModel.h
//  qqChat
//
//  Created by kirin on 2019/5/27.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendModel : NSObject

@property(nonatomic,copy) NSString *icon;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *intro;
@property(nonatomic,assign,getter=isVip) BOOL vip;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)friendWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

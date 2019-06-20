//
//  CZMessage.h
//  qqChat
//
//  Created by kirin on 2019/5/23.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    CZMessageTypeMe = 0,//表示自己
    CZMessageTypeOther = 1 //表示对方
} CZMessageType;

@interface CZMessage : NSObject

//消息正文
@property (nonatomic,copy) NSString *text;

//消息发送时间
@property (nonatomic,copy) NSString *time;

//消息的类型
@property(nonatomic,assign) CZMessageType type;

/**
 *  是否隐藏时间
 */
@property (nonatomic, assign) BOOL hideTime;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)messageWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

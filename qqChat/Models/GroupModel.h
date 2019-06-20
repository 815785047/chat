//
//  GroupModel.h
//  qqChat
//
//  Created by kirin on 2019/5/28.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign) int online;

@property(nonatomic,strong) NSArray *friends;

@property(nonatomic,assign,getter=isVisible) BOOL visible;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)groupWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

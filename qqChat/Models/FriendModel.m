//
//  FriendModel.m
//  qqChat
//
//  Created by kirin on 2019/5/27.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(instancetype)friendWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
   
}
@end

//
//  CZMessage.m
//  qqChat
//
//  Created by kirin on 2019/5/23.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import "CZMessage.h"

@implementation CZMessage

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        NSLog(@"%@",dict);
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(instancetype)messageWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    if([key isEqualToString:@"id"])
//    {
//        self.age=value;
//    }
//    if([key isEqualToString:@"username"])
//    {
//        self.name=value;
//    }
}
@end

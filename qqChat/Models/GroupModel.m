//
//  GroupModel.m
//  qqChat
//
//  Created by kirin on 2019/5/28.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import "GroupModel.h"
#import "FriendModel.h"
@implementation GroupModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict_sub in self.friends) {
            FriendModel *model = [FriendModel friendWithDict:dict_sub];
            [arrayModels addObject:model];
        }
        self.friends = arrayModels;
    }
    
    return self;
}

+(instancetype)groupWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end

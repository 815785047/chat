//
//  NSString+CZNSStringExit.m
//  qqChat
//
//  Created by kirin on 2019/5/24.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import "NSString+CZNSStringExit.h"

@implementation NSString (CZNSStringExit)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end

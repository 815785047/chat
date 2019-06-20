//
//  NSString+CZNSStringExit.h
//  qqChat
//
//  Created by kirin on 2019/5/24.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (CZNSStringExit)
/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end

NS_ASSUME_NONNULL_END

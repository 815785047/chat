//
//  CZMessageFrame.h
//  qqChat
//
//  Created by kirin on 2019/5/23.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@class CZMessage;
NS_ASSUME_NONNULL_BEGIN

// 正文的字体
#define MJTextFont [UIFont systemFontOfSize:15]

// 正文的内边距
#define MJTextPadding 20

@interface CZMessageFrame : NSObject

/**
 *  头像的frame
 */
@property (nonatomic, assign, readonly) CGRect iconF;
/**
 *  时间的frame
 */
@property (nonatomic, assign, readonly) CGRect timeF;
/**
 *  正文的frame
 */
@property (nonatomic, assign, readonly) CGRect textF;
/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

/**
 *  数据模型
 */
@property (nonatomic, strong) CZMessage *message;

@end

NS_ASSUME_NONNULL_END

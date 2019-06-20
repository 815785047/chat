//
//  CZMessageCell.m
//  qqChat
//
//  Created by kirin on 2019/5/23.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import "CZMessageCell.h"
#import "CZMessage.h"
#import "CZMessageFrame.h"
#import "UIImage+Extension.h"

@interface CZMessageCell()
/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeView;
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  正文
 */
@property (nonatomic, weak) UIButton *textView;
@end


@implementation CZMessageCell

+ (instancetype)messageCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"message_cell";
    CZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CZMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 子控件的创建和初始化
        // 1.时间
        UILabel *timeView = [[UILabel alloc] init];
        timeView.textAlignment = NSTextAlignmentCenter;
        timeView.textColor = [UIColor grayColor];
        timeView.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        
        // 2.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        // 3.正文
        UIButton *textView = [[UIButton alloc] init];
        textView.titleLabel.numberOfLines = 0; // 自动换行
        textView.titleLabel.font = MJTextFont;
        textView.contentEdgeInsets = UIEdgeInsetsMake(MJTextPadding, MJTextPadding, MJTextPadding, MJTextPadding);
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        // 4.设置cell的背景色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setMessageFrame:(CZMessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;
    
    CZMessage *message = messageFrame.message;
    
    // 1.时间
    self.timeView.text = message.time;
    self.timeView.frame = messageFrame.timeF;
    self.timeView.hidden = message.hideTime;
    // 2.头像
    NSString *icon = (message.type == CZMessageTypeMe) ? @"me" : @"other";
    self.iconView.image = [UIImage imageNamed:icon];
    self.iconView.frame = messageFrame.iconF;
    
    // 3.正文
    [self.textView setTitle:message.text forState:UIControlStateNormal];
    self.textView.frame = messageFrame.textF;
    
    // 4.正文的背景
    if (message.type == CZMessageTypeMe) { // 自己发的,蓝色
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_nor"] forState:UIControlStateNormal];
    } else { // 别人发的,白色
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_recive_nor"] forState:UIControlStateNormal];
    }
}


@end

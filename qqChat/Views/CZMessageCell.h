//
//  CZMessageCell.h
//  qqChat
//
//  Created by kirin on 2019/5/23.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZMessageFrame.h"
NS_ASSUME_NONNULL_BEGIN

@interface CZMessageCell : UITableViewCell

@property(nonatomic,strong)CZMessageFrame *messageFrame;

+(instancetype)messageCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END

//
//  FriendCell.h
//  qqChat
//
//  Created by kirin on 2019/5/28.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendModel;
NS_ASSUME_NONNULL_BEGIN

@interface FriendCell : UITableViewCell


+(instancetype)friendCellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)FriendModel *frienModel;
@end

NS_ASSUME_NONNULL_END

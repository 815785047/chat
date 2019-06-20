//
//  GroupHeaderView.h
//  qqChat
//
//  Created by kirin on 2019/5/29.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
NS_ASSUME_NONNULL_BEGIN
@class GroupHeaderView;

@protocol GroupHeaderViewDelegate <NSObject>

-(void)groupHeaderViewDidClickTitleButton:(GroupHeaderView *)groupHeaderView;

@end

typedef void(^HeaderViewBlock)(id);
@interface GroupHeaderView : UITableViewHeaderFooterView

+(instancetype)groupheaderViewWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)GroupModel *group;
@property(nonatomic,weak) id<GroupHeaderViewDelegate> delegate;

@property(nonatomic,copy) HeaderViewBlock block;
@end



NS_ASSUME_NONNULL_END

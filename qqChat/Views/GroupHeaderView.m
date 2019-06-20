//
//  GroupHeaderView.m
//  qqChat
//
//  Created by kirin on 2019/5/29.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import "GroupHeaderView.h"

@interface GroupHeaderView()

@property(nonatomic,weak) UIButton *btnGroupTitle;
@property(nonatomic,weak) UILabel *lblCount;

@end
@implementation GroupHeaderView

+ (instancetype)groupheaderViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"group_headerView";
    GroupHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    if (!headView) {
        headView = [[GroupHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *btnGroupTitle = [[UIButton alloc] init];
        self.btnGroupTitle = btnGroupTitle;
        btnGroupTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btnGroupTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btnGroupTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [btnGroupTitle setImage:[UIImage imageNamed:@"ico_list"] forState:UIControlStateNormal];
        [btnGroupTitle setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        btnGroupTitle.imageView.contentMode = UIViewContentModeCenter;
        btnGroupTitle.imageView.clipsToBounds = NO;
        [self.contentView addSubview:btnGroupTitle];
        [btnGroupTitle addTarget:self action:@selector(btnGroupTitleClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *lblCount = [[UILabel alloc] init];
        self.lblCount = lblCount;
        [self.contentView addSubview:lblCount];
        
    }
    
    return self;
}

-(void)btnGroupTitleClicked{
    
    self.group.visible = !self.group.isVisible;
    
    //代理
    if ([self.delegate respondsToSelector:@selector(groupHeaderViewDidClickTitleButton:)]) {
        [self.delegate groupHeaderViewDidClickTitleButton:self];
    }
    
    //block
    if(self.block){
        self.block(self);
    }
}
-(void)setGroup:(GroupModel *)group{
    _group = group;
    [self.btnGroupTitle setTitle:group.name forState:UIControlStateNormal];
    self.lblCount.text = [NSString stringWithFormat:@"%d / %ld",group.online,group.friends.count];
    if (self.group.isVisible) {
        //改变按钮左边图片的角度
        self.btnGroupTitle.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.btnGroupTitle.imageView.transform=CGAffineTransformMakeRotation(0);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.btnGroupTitle.frame = self.bounds;
    CGFloat lblW = 100;
    CGFloat lblH = self.bounds.size.height;
    CGFloat lblX = self.bounds.size.width - 10 - lblW;
    CGFloat lblY = 0 ;
    self.lblCount.frame = CGRectMake(lblX, lblY, lblW, lblH);
}

//当前界面加载到父控件时调用
-(void)didMoveToSuperview{
    if (self.group.isVisible) {
        //改变按钮左边图片的角度
        self.btnGroupTitle.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.btnGroupTitle.imageView.transform=CGAffineTransformMakeRotation(0);
    }
}
@end

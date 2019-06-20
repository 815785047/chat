//
//  FriendTableViewController.m
//  qqChat
//
//  Created by kirin on 2019/5/27.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import "FriendTableViewController.h"
#import "GroupModel.h"
#import "FriendModel.h"
#import "FriendCell.h"
#import "GroupHeaderView.h"
#import "ViewController.h"
@interface FriendTableViewController ()<UITableViewDelegate,UITableViewDataSource,GroupHeaderViewDelegate>

//保存所有的朋友信息
@property(nonatomic,strong)NSArray *groups;

@end

@implementation FriendTableViewController

-(NSArray *)groups{
    if (!_groups) {
        NSArray *friendArray = @[@{@"name":@"好友列表1",@"online":@"1",@"friends":@[@{@"icon":@"me",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0}]},@{@"name":@"好友列表2",@"online":@"1",@"friends":@[@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0}]},@{@"name":@"好友列表3",@"online":@"1",@"friends":@[@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0},@{@"icon":@"me.png",@"intro":@"作业又没写好,唉",@"name":@"小明",@"vip":@0}]}];
        
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in friendArray) {
            GroupModel *model = [GroupModel groupWithDict:dict];
            [arrayModels addObject:model];
        }
        _groups = arrayModels;
    }
    return _groups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.grayColor;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 44;
    
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GroupModel *group = self.groups[section];
    if (group.isVisible) {
        return  group.friends.count;
    }else{
        return 0;
    }
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//
//    GroupModel *group = self.groups[section];
//    return group.name;
//}
//自定义headerView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    GroupModel *group = self.groups[section];
    
    GroupHeaderView *headerView = [GroupHeaderView groupheaderViewWithTableView:tableView];
    
    headerView.tag = section;
    
    headerView.group = group;
    
    headerView.delegate = self;
    headerView.block = ^(id sender) {
        NSLog(@"执行了block %@",sender);
    };
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GroupModel *group = self.groups[indexPath.section];
    FriendModel *friend = group.friends[indexPath.row];
    
    FriendCell *cell = [FriendCell friendCellWithTableView:tableView];
    cell.frienModel = friend;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ViewController *VC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"vc"];
    
    [self.navigationController pushViewController:VC animated:YES];
}


//代理方法
- (void)groupHeaderViewDidClickTitleButton:(GroupHeaderView *)groupHeaderView{
//    [self.tableView reloadData];
    
    NSIndexSet *idxSet = [NSIndexSet indexSetWithIndex:groupHeaderView.tag];
    [self.tableView reloadSections:idxSet withRowAnimation:UITableViewRowAnimationFade];
}
@end

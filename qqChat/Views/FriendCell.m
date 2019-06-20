//
//  FriendCell.m
//  qqChat
//
//  Created by kirin on 2019/5/28.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import "FriendCell.h"
#import "FriendModel.h"
@implementation FriendCell

+(instancetype)friendCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"friend_cell";
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setFrienModel:(FriendModel *)frienModel{
    _frienModel = frienModel;
    
    self.imageView.image = [UIImage imageNamed:frienModel.icon];
    self.textLabel.text = frienModel.name;
    self.detailTextLabel.text = frienModel.intro;
}
@end

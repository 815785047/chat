//
//  ViewController.m
//  qqChat
//
//  Created by kirin on 2019/5/23.
//  Copyright © 2019 kirin.hw. All rights reserved.
//

#import "ViewController.h"
#import "CZMessageFrame.h"
#import "CZMessage.h"
#import "CZMessageCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputView;

@property (nonatomic,strong) NSMutableArray *messageFrames;
@property (nonatomic, strong) NSDictionary *autoreply;
@end

@implementation ViewController

- (NSMutableArray *)messageFrames
{
    if (!_messageFrames) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
        
        NSMutableArray *mfArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            CZMessage *model = [CZMessage messageWithDict:dict];

//            // 消息模型
//            CZMessage *msg = [CZMessage messageWithDict:dict];
//
//            // 取出上一个模型
            CZMessageFrame *lastMf = [mfArray lastObject];
            CZMessage *lastMsg = lastMf.message;
            
            // 判断两个消息的时间是否一致
            model.hideTime = [model.time isEqualToString:lastMsg.time];
            
            //frame模型
            CZMessageFrame *modelFrame = [[CZMessageFrame alloc] init];
            modelFrame.message = model;
            
//            // 添加模型
            [mfArray addObject:modelFrame];
            
            
        }

        _messageFrames = mfArray;
    }
    return _messageFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
    // 1.表格的设置
    // 去除分割线
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO; // 不允许选中
    
    // 2.监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 3.设置文本框左边显示的view
    self.inputView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    // 永远显示
    self.inputView.leftViewMode = UITextFieldViewModeAlways;
    self.inputView.delegate = self;
    
//    如果在iOS11上出了reload闪屏，在创建tableview的时候使用
    _tableView.estimatedRowHeight = 0;
}

/**
 *  当键盘改变了frame(位置和尺寸)的时候调用
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 设置窗口的颜色
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
    
    NSIndexPath *lastRowIndexPath = [NSIndexPath indexPathForRow:self.messageFrames.count-1 inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:lastRowIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",self.messageFrames.count);
    return self.messageFrames.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CZMessageFrame *mf = self.messageFrames[indexPath.row];
    return mf.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CZMessageCell *cell = [CZMessageCell messageCellWithTableView:tableView];
    
    cell.messageFrame = self.messageFrames[indexPath.row];;
    
    return cell;
}

/**
 *  当开始拖拽表格的时候就会调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 退出键盘
    [self.view endEditing:YES];
}


#pragma mark - 文本框代理
/**
 *  点击了return按钮(键盘最右下角的按钮)就会调用
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    // 1.自己发一条消息
    [self addMessage:textField.text type:CZMessageTypeMe];
    
    // 2.自动回复一条消息
    NSString *reply = [self replayWithText:textField.text];
    [self addMessage:reply type:CZMessageTypeOther];
    
    // 3.清空文字
    self.inputView.text = nil;
    
    // 返回YES即可
    return YES;
}

/**
 *  发送一条消息
 */
- (void)addMessage:(NSString *)text type:(CZMessageType)type
{
    // 1.数据模型
    CZMessage *msg = [[CZMessage alloc] init];
    msg.type = type;
    msg.text = text;
    // 设置数据模型的时间
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    // NSDate  --->  NSString
    // NSString ---> NSDate
    //    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //  2014-08-09 15:45:56
    // 09/08/2014  15:45:56
    msg.time = [fmt stringFromDate:now];
    
    // 看是否需要隐藏时间
    CZMessageFrame *lastMf = [self.messageFrames lastObject];
    CZMessage *lastMsg = lastMf.message;
    msg.hideTime = [msg.time isEqualToString:lastMsg.time];
    
    // 2.frame模型
    CZMessageFrame *mf = [[CZMessageFrame alloc] init];
    mf.message = msg;
    [self.messageFrames addObject:mf];
    
    // 3.刷新表格
    [self.tableView reloadData];
    
    // 4.自动滚动表格到最后一行
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

/**
 *  根据自己发的内容取得自动回复的内容
 *
 *  @param text 自己发的内容
 */
- (NSString *)replayWithText:(NSString *)text
{
    for (int i = 0; i<text.length; i++) {
        NSString *word = [text substringWithRange:NSMakeRange(i, 1)];
        
        if (self.autoreply[word]) return self.autoreply[word];
    }
    
    return @"滚蛋";
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

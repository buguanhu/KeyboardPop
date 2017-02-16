//
//  ViewController.m
//  键盘
//
//  Created by siluo on 2017/2/16.
//  Copyright © 2017年 TH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) NSInteger y;
@property (nonatomic) NSInteger kH;
@end

#define MainW [UIScreen mainScreen].bounds.size.width
#define MainH [UIScreen mainScreen].bounds.size.height

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //使用NSNotificationCenter鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _y = cell.frame.size.height + cell.frame.origin.y;
    [self.textView becomeFirstResponder];
    [self change];
}

- (void)keyboardShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize为键盘尺寸
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //键盘高度
    _kH = kbSize.height;
    
    //改变textView的frame
    self.textView.frame = CGRectMake(0, MainH - _kH - 40, MainW, 40);
    
    //计算偏移量，20是状态栏高度，y其实就是cell底部到textView的y坐标的距离
    NSInteger y = ( _y + 20) - (MainH - (_kH + 40));
    
    //偏移量为正数
    if (y > 0) {
        [self.tableView setContentOffset:CGPointMake(0, y) animated:YES];
    }
}

- (void)change{

    //改变textView的frame
    self.textView.frame = CGRectMake(0, MainH - _kH - 40, MainW, 40);
    
    //计算偏移量，20是状态栏高度，y其实就是cell底部到textView的y坐标的距离
    NSInteger y = ( _y + 20) - (MainH - (_kH + 40));
    
    //偏移量为正数
    if (y > 0) {
        [self.tableView setContentOffset:CGPointMake(0, y) animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  DrawLineWork
//
//  Created by 黄嘉群 on 2020/5/23.
//  Copyright © 2020 黄嘉群. All rights reserved.
//

#import "ViewController.h"
#import "LF_showAViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
}

//展示一页少数据
- (IBAction)showA:(UIButton *)sender {
    LF_showAViewController *vc = [LF_showAViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}


//展示多数据实现可拖拽
- (IBAction)showB:(UIButton *)sender {
//    LF_showBViewController *vc = [LF_showBViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}
@end

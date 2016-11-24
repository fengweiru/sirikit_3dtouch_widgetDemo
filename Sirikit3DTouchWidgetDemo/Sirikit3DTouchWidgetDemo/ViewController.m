//
//  ViewController.m
//  Sirikit3DTouchWidgetDemo
//
//  Created by medzone on 2016/11/21.
//  Copyright © 2016年 fengweiru. All rights reserved.
//

#import "ViewController.h"
#import "FunctionViewController.h"

#define KScreenW   [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WidgetNotification" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"WidgetNotification" object:nil];
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"demo";
    
    for (int i = 0 ; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[NSString stringWithFormat:@"按钮%d",i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(clickToAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake((KScreenW-60)/2, 100+40*i, 60, 30);
        [self.view addSubview:button];
    }
    
}

- (void)clickToAction:(UIButton *)sender
{
    [self pushToDetailWithType:sender.tag];
}

- (void)pushToDetailWithType:(NSInteger)type
{
    NSString *title = @"";
    switch (type) {
        case 0:
            title = @"功能widget";
            break;
        case 1:
            title = @"功能3dtouch";
            break;
        case 2:
            title = @"功能sirikit";
            break;
            
        default:
            break;
    }
    
    
    FunctionViewController *vc = [[FunctionViewController alloc] initWithTitle:title];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)receiveNotification:(NSNotification *)note
{
    NSInteger i = [note.object integerValue];
    
    [self pushToDetailWithType:i];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

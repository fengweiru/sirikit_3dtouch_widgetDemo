//
//  TodayViewController.m
//  WidgetDemoToday
//
//  Created by medzone on 2016/11/21.
//  Copyright © 2016年 fengweiru. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#define KScreenW   [[UIScreen mainScreen] bounds].size.width

@interface TodayViewController () <NCWidgetProviding>
{
    UILabel *_label;
    NSString *_apiversion;
}

@end

@implementation TodayViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *urlstring = @"http://api.mcloudlife.com/api/version";
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [request setValue:@"mCloud/3.2.2.0D" forHTTPHeaderField:@"User-Agent"];
    __weak typeof(self) weakSelf = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _apiversion = dic[@"apiversion"];
        [weakSelf updateString];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)setupUI
{
    self.preferredContentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 100);
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[NSString stringWithFormat:@"按钮%d",i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(clickToAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake((60+(KScreenW-180-30)/2)*i, 25, 60, 30);
        [self.view addSubview:button];
    }
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, KScreenW, 20)];
    _label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18];
    _label.textColor = [UIColor blackColor];
    [self.view addSubview:_label];
}

- (void)autoUpdateTimer
{
//    NSTimer *updateTimer = [NSTimer scheduledTimerWithTimeInterval:<#(NSTimeInterval)#>
//                                                            target:<#(nonnull id)#>
//                                                          selector:<#(nonnull SEL)#>
//                                                          userInfo:<#(nullable id)#>
//                                                           repeats:<#(BOOL)#>];
}

- (void)updateString
{
    _label.text = _apiversion;
}


- (void)clickToAction:(UIButton *)sender
{
    
    //通过extensionContext借助host app调起app
    [self.extensionContext openURL:[NSURL URLWithString:[NSString stringWithFormat:@"myWidget://%ld",(long)sender.tag]] completionHandler:^(BOOL success) {
        NSLog(@"open url result:%d",success);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)beginRequestWithExtensionContext:(NSExtensionContext *)context
{
    
}

@end

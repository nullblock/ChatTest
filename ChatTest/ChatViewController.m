//
//  ChatViewController.m
//  ChatTest
//
//  Created by null on 11/6/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTableView.h"
#import "CihiBottomView.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ChatTableView *tableview = [[ChatTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 440)];
    
    [self.view addSubview:tableview];
    
    CihiBottomView *bottomview = [[CihiBottomView alloc]init];
    bottomview.control = self;
    [bottomview setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:bottomview];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

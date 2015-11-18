//
//  ChatViewController.m
//  ChatTest
//
//  Created by null on 11/6/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "ChatViewController.h"


@interface ChatViewController ()<CihiBottomAudioViewDelegate, CihiAudioRecordInfoViewDelegate, CihiBottomViewDelegate>
{
    CihiAudioRecordInfoView *audioRecordInfo;
    CihiBottomView *bottomview;
}
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ChatTableView *tableview = [[ChatTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 440)];
    
    [self.view addSubview:tableview];
    
    bottomview = [[CihiBottomView alloc]initWithOutChat];
    bottomview.deleg = self;
    bottomview.control = self;
    [self.view addSubview:bottomview];
    
    
}

- (void)setAudioDelegate:(CihiBottomAudioView *)audioView {
    audioView.pressHoldOnRecord.deleg = self;
    audioView.tapOnRecord.deleg = self;
}

//开始录制 传送出来点击的手势
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)startRecordWithGesture:(UIGestureRecognizer *)gesture {
    if (!audioRecordInfo) {
        audioRecordInfo = [[CihiAudioRecordInfoView alloc] init];

        audioRecordInfo.deleg =self;
    }
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        [audioRecordInfo setTapFrame];
    } else {
        [audioRecordInfo setLongPressFrame];
    }
    [self.view addSubview:audioRecordInfo];
    [audioRecordInfo startMessage];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//结束录制 结束录制
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)stopRecordWithGesture:(UIGestureRecognizer *)gesture {
    [audioRecordInfo stopMessage];
    [audioRecordInfo removeFromSuperview];
}

- (void)stopAudioRecordInfoWithNum {
    [bottomview.audioView.pressHoldOnRecord stopShowRedPoint];
    [bottomview.audioView.tapOnRecord stopShowRedPoint];
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

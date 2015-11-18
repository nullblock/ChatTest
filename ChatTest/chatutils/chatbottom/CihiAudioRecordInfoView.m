//
//  CihiAudioRecordInfoView.m
//  ChatTest
//
//  Created by null on 11/18/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "CihiAudioRecordInfoView.h"
#define COLOR(A, B, C, D) [UIColor colorWithRed:A/255.0f green:B/255.0f blue:C/255.0f alpha:D]
@implementation CihiAudioRecordInfoView
{
    float width;                //宽
    float height;               //高
///////////////////////////////////////////////////////////////////////////////////////////////////
    UIView *shadeView;
    UIImageView *audioImage;
    UILabel *labCountdown;
    UILabel *labMessage;
///////////////////////////////////////////////////////////////////////////////////////////////////
    NSTimer *msgTimer;
    NSInteger countDownNum;
}
- (id)init {
    self = [super init];
    if (self) {
///////////////////////////////////////////////////////////////////////////////////////////////////
        width      = CGRectGetWidth([UIScreen mainScreen].bounds);
        height     = CGRectGetHeight([UIScreen mainScreen].bounds);
///////////////////////////////////////////////////////////////////////////////////////////////////
        self.frame = CGRectMake(0, 0, width, height);
        self.center = CGPointMake(width/2, height/2);
        
        [self addView];
    }
    return self;
}

- (void)addView {
    shadeView = [[UIView alloc]init];
    shadeView.frame   = CGRectMake(0, 0, width / 2, height / 6);
    shadeView.center  = self.center;
    shadeView.backgroundColor = COLOR(0, 0, 0, 0.7);
    shadeView.layer.masksToBounds = YES;
    shadeView.layer.cornerRadius = 6;
    float shadeWidth  = CGRectGetWidth(shadeView.frame);
    float shadeHeight = CGRectGetHeight(shadeView.frame);
    [self addSubview:shadeView];
///////////////////////////////////////////////////////////////////////////////////////////////////
    labMessage               = [[UILabel alloc]init];
    labMessage.text          = @"手指上滑，取消发送";
    labMessage.textAlignment = NSTextAlignmentCenter;
    labMessage.font          = [UIFont systemFontOfSize:13];
    labMessage.textColor     = [UIColor whiteColor];
    CGSize messagesize       = [self getStringSize:labMessage.text SizeWithFont:labMessage.font ConstrainedToSize:CGSizeMake(shadeWidth, shadeHeight)];
    labMessage.frame         = CGRectMake(0, 0, messagesize.width, messagesize.height);
    labMessage.center        = CGPointMake(shadeWidth / 2, shadeHeight / 2 + 15);
    [shadeView addSubview:labMessage];
///////////////////////////////////////////////////////////////////////////////////////////////////
    labCountdown               = [[UILabel alloc]init];
    labCountdown.text          = @"60 / 60";
    labCountdown.font          = [UIFont systemFontOfSize:20];
    labCountdown.textColor     = [UIColor whiteColor];
    CGSize countdownsize       = [self getStringSize:labCountdown.text SizeWithFont:labCountdown.font ConstrainedToSize:CGSizeMake(shadeWidth, shadeHeight)];
    labCountdown.frame         = CGRectMake(CGRectGetMaxX(labMessage.frame) - countdownsize.width - 2,
                                            CGRectGetMinY(labMessage.frame) - 33,
                                            countdownsize.width + 2,
                                            countdownsize.height);
    labCountdown.textAlignment = NSTextAlignmentRight;
    [shadeView addSubview:labCountdown];
///////////////////////////////////////////////////////////////////////////////////////////////////
    audioImage             = [[UIImageView alloc]init];
    audioImage.frame       = CGRectMake(CGRectGetMinX(labMessage.frame) - 2,
                                        CGRectGetMinY(labCountdown.frame),
                                        CGRectGetHeight(labCountdown.frame),
                                        CGRectGetHeight(labCountdown.frame));
    audioImage.contentMode = UIViewContentModeScaleAspectFit;
    audioImage.image       = [UIImage imageNamed:@"chat_shade_audio"];
    [shadeView addSubview:audioImage];
    
}

- (void)stopMessage {
    if (msgTimer) {
        [msgTimer invalidate];
        msgTimer = nil;
    }
    countDownNum = 60;
}

- (void)startMessage {
    if (msgTimer) {
        [msgTimer invalidate];
        msgTimer = nil;
    }
    countDownNum = 3;
    msgTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setLabCountDownTest) userInfo:nil repeats:YES];//[NSTimer timerWithTimeInterval:1 target:self selector:@selector(setLabCountDownTest) userInfo:nil repeats:0];
}

- (void)setLabCountDownTest {
    if (countDownNum == 0) {
        [msgTimer invalidate];
        msgTimer = nil;
        [self.deleg stopAudioRecordInfoWithNum];
        [self removeFromSuperview];
        labCountdown.text = @"60 / 60";
        return;
    }
    labCountdown.text = [NSString stringWithFormat:@"%ld / 60", countDownNum--];
}

- (CGSize)getStringSize:(NSString *)string SizeWithFont:(UIFont *)font ConstrainedToSize:(CGSize)size {
    return [string sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

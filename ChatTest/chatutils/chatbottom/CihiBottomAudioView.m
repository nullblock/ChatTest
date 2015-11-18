//
//  CihiBottomAudioView.m
//  ChatTest
//
//  Created by null on 11/10/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "CihiBottomAudioView.h"

@implementation CihiBottomAudioView
{
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    UIScrollView *_scroll;
    UIPageControl *_pageControl;
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    UIView *_redioPointCenterRedCircle;     //按下说话的中心点
    ///////////////////////////////////////////////////////////////////////////////////////////////////

}
@synthesize control;
@synthesize redioImg, redioPoint, labInfo;
@synthesize deleg;
@synthesize pressHoldOnRecord, tapOnRecord;
- (id)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 253);
        self.backgroundColor = COLOR(217, 221, 214, 1.0);
    }
    
    return self;
}

/*****************************************
 *  @author null, 15-11-18 10:11:10
 *
 *  @brief  分两种 一种是按住不动说话录制，一种是按下就可以说话 再次按下就结束
 *
 *  @since 1.0
 ****************************************/
- (void)addAllScroller {
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    pressHoldOnRecord = [[CihiBottomAudioView alloc]init];
    pressHoldOnRecord.control = control;
    [pressHoldOnRecord addview];
    [pressHoldOnRecord addLongPress];
    
    tapOnRecord = [[CihiBottomAudioView alloc]init];
    tapOnRecord.control = control;
    [tapOnRecord addview];
    [tapOnRecord addTapPress];
    [tapOnRecord.labInfo setText:@"按下说话"];
    [tapOnRecord setFrame:CGRectMake(CGRectGetMaxX(pressHoldOnRecord.frame), 0, CGRectGetWidth(tapOnRecord.frame), CGRectGetHeight(tapOnRecord.frame))];
    ///////////////////////////////////////////////////////////////////////////////////////////////////
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _scroll.pagingEnabled                  = YES;
    _scroll.bounces                        = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    [_scroll addSubview:pressHoldOnRecord];
    [_scroll addSubview:tapOnRecord];
    
    [_scroll setContentSize:CGSizeMake(CGRectGetMaxX(tapOnRecord.frame), CGRectGetHeight(tapOnRecord.frame))];
    [self addSubview:_scroll];
    
}

- (void)addPageControlView {
    _pageControl     = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 10, CGRectGetWidth(self.frame), 10)];
    _scroll.delegate = self;
    [_pageControl setNumberOfPages:2];
    [_pageControl setCurrentPage:0];
    [self addSubview:_pageControl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pageControl setCurrentPage: scrollView.contentOffset.x / CGRectGetWidth(self.frame)];
}

/*****************************************
 *  @author null, 15-11-18 10:11:46
 *
 *  @brief  初始化view
 *
 *  @since 1.0
 ****************************************/
- (void)addview {
    float halfSelfWidth = CGRectGetWidth(self.frame) / 2;
    float halfSelfHeight = CGRectGetHeight(self.frame) / 2;
///////////////////////////////////////////////////////////////////////////////////////////////////
    float redioImgHeight = CGRectGetHeight(self.frame) / 5 * 3;
    redioImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, redioImgHeight, redioImgHeight)];
    [redioImg setCenter:CGPointMake(halfSelfWidth, halfSelfHeight)];
    [redioImg setImage:[UIImage imageNamed:@"tool_bar_sendaudio"]];
    [redioImg setUserInteractionEnabled:YES];
    [self addSubview:redioImg];
///////////////////////////////////////////////////////////////////////////////////////////////////
    redioPoint = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) / 10, 10, 10)];
    [redioPoint setCenter:CGPointMake(halfSelfWidth, redioPoint.center.y)];
    [redioPoint setBackgroundColor:[UIColor whiteColor]];
    [redioPoint.layer setMasksToBounds:YES];
    [redioPoint.layer setCornerRadius:5];
    [self addSubview:redioPoint];
///////////////////////////////////////////////////////////////////////////////////////////////////
    float labInfoHeight = CGRectGetHeight(self.frame) / 5;
    float labInfoY = CGRectGetHeight(self.frame) - labInfoHeight;
    labInfo = [[UILabel alloc]initWithFrame:CGRectMake(0, labInfoY, CGRectGetWidth(self.frame), labInfoHeight)];
    [labInfo setTextAlignment:NSTextAlignmentCenter];
    [labInfo setTextColor:[UIColor grayColor]];
    [labInfo setText:@"按住说话"];
    [self addSubview:labInfo];
}

#pragma mark --点击手势添加和实现
- (void)addTapPress {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPress:) ];
    [redioImg addGestureRecognizer:tap];
}

- (void)tapPress:(UILongPressGestureRecognizer *)tap {
    if (!_redioPointCenterRedCircle) {
        _redioPointCenterRedCircle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        [_redioPointCenterRedCircle setBackgroundColor:[UIColor redColor]];
        [_redioPointCenterRedCircle setCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2)];
        [self addSubview:_redioPointCenterRedCircle];
        
        [redioPoint setBackgroundColor:[UIColor redColor]];
        [self.deleg startRecordWithGesture:tap];
    } else {
        [self stopShowRedPoint];
        [self.deleg stopRecordWithGesture:tap];
    }
}
#pragma mark --长按手势添加和实现
- (void)addLongPress {
    UILongPressGestureRecognizer *lon = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpress:)];
    [redioImg addGestureRecognizer:lon];
}

- (void)longpress:(UILongPressGestureRecognizer *)lon {
    if (lon.state == UIGestureRecognizerStateBegan) {
        [self.deleg startRecordWithGesture:lon];
        [redioPoint setBackgroundColor:[UIColor redColor]];
    } else if (lon.state == UIGestureRecognizerStateEnded) {
        [self.deleg stopRecordWithGesture:lon];
        [self stopShowRedPoint];
    }
}

- (void)stopShowRedPoint {
    [_redioPointCenterRedCircle removeFromSuperview];
    _redioPointCenterRedCircle = nil;
    [redioPoint setBackgroundColor:[UIColor whiteColor]];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  CihiBottomAudioView.m
//  ChatTest
//
//  Created by null on 11/7/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "CihiBottomAudioView.h"

@implementation CihiBottomAudioView
{
    UIView *point;
    UIPageControl *pagecontrol;
}

@synthesize control;
@synthesize audioimg = _audioimg, redPoint = _redPoint, labInfo = _labInfo;
- (id)init {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), 253)];
    }
    return self;
}

- (void)addAllScroller {
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [scroll setBackgroundColor:[UIColor orangeColor]];
    CihiBottomAudioView *control1 = [[CihiBottomAudioView alloc]init];
    [control1 setFrame:CGRectMake(0, 0, CGRectGetWidth(control1.frame), CGRectGetHeight(control1.frame))];
    control1.control = control;
    [control1 addview];
    [control1 addLongPressGesture];
    
    CihiBottomAudioView *control2 = [[CihiBottomAudioView alloc]init];
    control2.control = control;
    [control2 addview];
    [control2 addTapPressGesture];
    [control2.labInfo setText:@"点击说话"];
    [control2 setFrame:CGRectMake(CGRectGetWidth(self.frame), 0, CGRectGetWidth(control2.frame), CGRectGetHeight(control2.frame))];
    
    [scroll addSubview:control1];
    [scroll addSubview:control2];
    
    [scroll setContentSize:CGSizeMake(CGRectGetMaxX(control2.frame), CGRectGetHeight(control2.frame))];
    
    [scroll setPagingEnabled:YES];
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setDelegate:self];
    
    [self addSubview:scroll];

}

- (void)addPageControlView {
    pagecontrol = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 10, CGRectGetWidth(self.frame), 10)];
    [pagecontrol setNumberOfPages:2];
    [pagecontrol setCurrentPage:0];
    [self addSubview:pagecontrol];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [pagecontrol setCurrentPage:scrollView.contentOffset.x / CGRectGetWidth(self.frame)];
}

- (void)addview {
    float w = CGRectGetWidth(self.frame);
    float h = CGRectGetHeight(self.frame);
    
    _audioimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, h / 5, h / 5 * 3, h / 5 * 3)];
    
    [_audioimg setImage:[UIImage imageNamed:@"tool_bar_sendaudio"]];
    [_audioimg setContentMode:UIViewContentModeScaleAspectFit];
    [_audioimg setCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/ 2)];
    [_audioimg setUserInteractionEnabled:YES];
    [self addSubview:_audioimg];
    
    _redPoint = [[UIImageView alloc]initWithFrame:CGRectMake(0, h / 10, 10, 10)];
    [_redPoint.layer setMasksToBounds:YES];
    [_redPoint.layer setCornerRadius:5];
    [_redPoint setBackgroundColor:[UIColor grayColor]];
    [_redPoint setCenter:CGPointMake(_audioimg.center.x, _redPoint.center.y)];
    [self addSubview:_redPoint];
    
    _labInfo = [[UILabel alloc]initWithFrame:CGRectMake(0, h/5*4, w, h/5)];
    [_labInfo setText:@"按住说话"];
    [_labInfo setTextColor:[UIColor grayColor]];
    [_labInfo setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_labInfo];
    
    
}

- (void)addLongPressGesture {
    UILongPressGestureRecognizer *lon = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(audioClick:)];
    [_audioimg addGestureRecognizer:lon];
}

- (void)addTapPressGesture {
    UITapGestureRecognizer *lon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(audioTap:)];
    [_audioimg addGestureRecognizer:lon];
}

- (void)audioTap:(UITapGestureRecognizer *)tappress {
    if (point == nil) {
        point = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [point setBackgroundColor:[UIColor redColor]];
        [point.layer setMasksToBounds:YES];
        [point.layer setCornerRadius:15];
        [point setCenter:_audioimg.center];
        [self addSubview:point];
        [_redPoint setBackgroundColor:[UIColor redColor]];
    } else {
        [_redPoint setBackgroundColor:[UIColor grayColor]];
        [point removeFromSuperview];
        point = nil;
    }
}

- (void)audioClick:(UILongPressGestureRecognizer *)longpress {
    if (longpress.state == UIGestureRecognizerStateBegan) {
        [_redPoint setBackgroundColor:[UIColor redColor]];
    } else if (longpress.state == UIGestureRecognizerStateEnded) {
        [_redPoint setBackgroundColor:[UIColor grayColor]];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

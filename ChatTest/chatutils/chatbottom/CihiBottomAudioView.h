//
//  CihiBottomAudioView.h
//  ChatTest
//
//  Created by null on 11/10/15.
//  Copyright © 2015 null. All rights reserved.
//

#import <UIKit/UIKit.h>
#define COLOR(A, B, C, D) [UIColor colorWithRed:A/255.0f green:B/255.0f blue:C/255.0f alpha:D]

@protocol CihiBottomAudioViewDelegate
///////////////////////////////////////////////////////////////////////////////////////////////////
//开始录制
//开始录制 传送出来点击的手势
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)startRecordWithGesture:(UIGestureRecognizer *)gesture;
///////////////////////////////////////////////////////////////////////////////////////////////////
//结束录制 结束录制
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)stopRecordWithGesture:(UIGestureRecognizer *)gesture;

@end


@interface CihiBottomAudioView : UIView <UIScrollViewDelegate>
{
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
@property (nonatomic, assign) id<CihiBottomAudioViewDelegate> deleg;
///////////////////////////////////////////////////////////////////////////////////////////////////
@property (nonatomic, strong) UIImageView *redioImg;
@property (nonatomic, strong) UIImageView *redioPoint;
@property (nonatomic, strong) UILabel *labInfo;
@property (nonatomic, assign) UIViewController *control;

@property (nonatomic, strong) CihiBottomAudioView *pressHoldOnRecord;
@property (nonatomic, strong) CihiBottomAudioView *tapOnRecord;

- (void)addAllScroller;
- (void)addPageControlView;

- (void)addview;

- (void)addTapPress;
- (void)addLongPress;
- (void)stopShowRedPoint;
@end

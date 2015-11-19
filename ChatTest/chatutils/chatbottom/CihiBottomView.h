//
//  CihiBottomView.h
//  ChatTest
//
//  Created by null on 11/6/15.
//  Copyright © 2015 null. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CihiTextView.h"

#import "CihiBottomAudioView.h"
#import "CihiBottomFaceView.h"
#import "CihiBottomAddtionView.h"

#define FRAME(A, B, C, D) CGRectMake( A, B, C, D)



typedef enum {
    AUDIO   = 101,//左边按钮
    FACE    = 102,//中间按钮
    ADDTION = 103,//右边按钮
    TEXT    = 104,//键盘按钮
}ISSHOWTYPE;

@protocol CihiBottomViewDelegate

- (void)setAudioDelegate:(CihiBottomAudioView *)_audioView;
- (void)setAddtionDelegate:(CihiBottomAddtionView *)_addtionView;

@end

@interface CihiBottomView : UIView


//当前显示出来的面板
@property (nonatomic, assign) ISSHOWTYPE showUIType;
//添加他的UIViewcontroller
@property (nonatomic, assign) UIViewController *control;
//语音按钮
@property (nonatomic, strong) CihiBottomAudioView *audioView;
//表情列表
@property (nonatomic, strong) CihiBottomFaceView *faceView;
//附加列表
@property (nonatomic, strong) CihiBottomAddtionView *addtionView;

@property (nonatomic, assign) id<CihiBottomViewDelegate> deleg;
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithOutChat;//非聊天输入框初始化
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithChat;//聊天输入框初始化
///////////////////////////////////////////////////////////////////////////////////////////////////
//非聊天输入框初始化调用
- (void)addOtherBtnAndView;
//非聊天输入框初始化坐标
- (void)setOtherBtnOriginFrame;
//非聊天按钮图片
- (void)setOtherBtnImage;
///////////////////////////////////////////////////////////////////////////////////////////////////
//聊天输入框初始化调用
- (void)addCustomChatBtnAndView;
//正常聊天初始化位置坐标
- (void)setCustomChatBtnOriginFrame;
//阅后即焚聊天初始化坐标
- (void)setBurnChatBtnOriginFrame;
//阅后即焚按钮图片
- (void)setBurnChatBtnImage;
//原始按钮图片
- (void)setCustomChatBtnImage;













@end

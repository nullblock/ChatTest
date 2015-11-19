//
//  CihiBottomView.m
//  ChatTest
//
//  Created by null on 11/6/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "CihiBottomView.h"


@interface CihiBottomView() <CihiTextViewDelegate>

@end

@implementation CihiBottomView
{
    float width;                //宽
    float height;               //高
///////////////////////////////////////////////////////////////////////////////////////////////////
    //初始化时候显示的高度
    CGFloat selfHeight;
///////////////////////////////////////////////////////////////////////////////////////////////////
    UIButton *_leftbtn;         //左边按钮
    UIButton *_midbtn;          //中间按钮
    UIButton *_rightbtn;        //右边按钮
    UIButton *_keyboardbtn;     //键盘按钮
    UIButton *_closeBurnBtn;    //关闭阅后即焚的按钮
    CihiTextView *_inputview;   //输入框
    UIView *_bginputview;       //输入框背景
///////////////////////////////////////////////////////////////////////////////////////////////////
    BOOL isShowKeyBorard;           //是否显示键盘

    float KEYBOARDHEIGHT;     //键盘高度
///////////////////////////////////////////////////////////////////////////////////////////////////
    BOOL isBurnStatus;
}

@synthesize showUIType;
@synthesize control;

@synthesize audioView = _audioView, addtionView = _addtionView, faceView = _faceView;

- (id)initWithOutChat {
    self = [self init];
    [self addOtherBtnAndView];
    [self setOtherBtnImage];
    [self setOtherBtnOriginFrame];
    return self;
}

- (id)initWithChat {
    self = [self init];
    [self addCustomChatBtnAndView];
    [self setCustomChatBtnImage];
    [self setCustomChatBtnOriginFrame];
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
///////////////////////////////////////////////////////////////////////////////////////////////////
        width      = CGRectGetWidth([UIScreen mainScreen].bounds);
        height     = CGRectGetHeight([UIScreen mainScreen].bounds);
        selfHeight = 44;//自身高度
        float y    = height - selfHeight;
        self.frame = CGRectMake(0, y, width, selfHeight);
///////////////////////////////////////////////////////////////////////////////////////////////////
        [self addNotification];
        
    }
    return self;
}

#pragma mark --注册的通知实现方法
/*****************************************
 *  @author null, 15-11-18 10:11:51
 *
 *  @brief  注册通知
 *
 *  @since  1.0
 ****************************************/
- (void)addNotification {
///////////////////////////////////////////////////////////////////////////////////////////////////
    //键盘显示隐藏通知注册
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//键盘实现方法
- (void)keyboardWillShow:(NSNotification *)notifacation {
    isShowKeyBorard = YES;
    [self setAllBtnHiddenIsNO];
    [_keyboardbtn setHidden:YES];
    NSDictionary *dic = notifacation.userInfo;
    NSValue *value = [dic objectForKey:UIKeyboardFrameBeginUserInfoKey];
    KEYBOARDHEIGHT = CGRectGetHeight(value.CGRectValue);
    self.frame = FRAME(0, height - selfHeight - KEYBOARDHEIGHT, width, selfHeight);
    float autoheight     = KEYBOARDHEIGHT;
    float showViewHeight = selfHeight + autoheight;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame         = FRAME(0, height - showViewHeight, width, showViewHeight);
        _addtionView.frame = FRAME(0 , showViewHeight + height, width, CGRectGetHeight(_addtionView.frame));
        _audioView.frame   = FRAME(0, showViewHeight + height, width, CGRectGetHeight(_audioView.frame));
        _faceView.frame    = FRAME(0, showViewHeight + height, width, CGRectGetHeight(_faceView.frame));
    }];
}

- (void)keyboardWillHide:(NSNotification *)notifacation {
    isShowKeyBorard = NO;
    KEYBOARDHEIGHT = 0;
}

#pragma mark --添加功能面板和面板方法
/*****************************************
 *  @author null, 15-11-18 14:11:43
 *
 *  @brief  评论使用的初始化方法
 *
 *  @since 1.0
 ****************************************/
- (void)addOtherBtnAndView {
    UIView *lineview = [[UIView alloc]init];
    lineview.frame = CGRectMake(0, 0, width, 0.5);
    lineview.backgroundColor = COLOR(0, 0, 0, 0.3);
    [self addSubview:lineview];
    
    //添加最左边按钮
    _leftbtn = [self setBtn:_leftbtn WithTag:AUDIO];
    [self addSubview:_leftbtn];
    
    //添加文字输入设备背景层
    _bginputview = [[UIView alloc]init];
    _bginputview.layer.masksToBounds = YES;
    _bginputview.layer.borderWidth   = 0.5;
    [self addSubview:_bginputview];
    
    //表情按钮
    _midbtn = [self setBtn:_midbtn WithTag:FACE];
    [_bginputview addSubview:_midbtn];
    
    //文字输入设备
    _inputview = [[CihiTextView alloc]init];
    _inputview.font = [UIFont systemFontOfSize:16.5f];
    _inputview.cihiDelegate = self;
    [_bginputview addSubview:_inputview];
    
    //键盘按钮
    _keyboardbtn = [self setBtn:_keyboardbtn WithTag:TEXT];
    _keyboardbtn.hidden = YES;
    [self addSubview:_keyboardbtn];
}

/*****************************************
 *  @author null, 15-11-18 14:11:11
 *
 *  @brief  聊天状态初始化
 *
 *  @since 1.0
 ****************************************/
- (void)addCustomChatBtnAndView {
    
    [self addOtherBtnAndView];

    //添加最右边按钮
    _rightbtn = [self setBtn:_rightbtn WithTag:ADDTION];
    [self addSubview:_rightbtn];
    
}
/*****************************************
 *  @author null, 15-11-06 14:11:30
 *
 *  @brief  初始化btn
 *  @since
 ****************************************/
- (UIButton *)setBtn:(UIButton *)btn WithTag:(NSInteger)tag{
    btn       = [[UIButton alloc]init];
    btn.tag   = tag;
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
#pragma mark --动画开始
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showCihiBottomViewOnly {
    self.frame = CGRectMake(0, height - selfHeight, width, selfHeight);
}
//动画显示开始
- (void)showCihiBottomAudio {
    if (_audioView == nil) {
        _audioView                 = [[CihiBottomAudioView alloc]init];
        _audioView.backgroundColor = [UIColor whiteColor];
        _audioView.control         = control;
        [_audioView addAllScroller];
//        [_audioView addPageControlView];
        [self.deleg setAudioDelegate:_audioView];
        [self addSubview:_audioView];
    }

    [self showViewAnimationWithView:self view2:_audioView view3:_faceView view4:_addtionView];

}

- (void)showCihiBottomFace {
    if (_faceView == nil) {
        _faceView                 = [[CihiBottomFaceView alloc]init];
        _faceView.backgroundColor = [UIColor brownColor];
        _faceView.control         = control;
        [self addSubview:_faceView];
    }
    
    [self showViewAnimationWithView:self view2:_faceView view3:_audioView view4:_addtionView];

}

- (void)showCihiBottomAdtion {
    if (_addtionView == nil) {
        _addtionView                 = [[CihiBottomAddtionView alloc]init];
        _addtionView.control         = control;
        [_addtionView setCustomBtnInfos];
        [self.deleg setAddtionDelegate:_addtionView];
        [self addSubview:_addtionView];
    }

    [self showViewAnimationWithView:self view2:_addtionView view3:_audioView view4:_faceView];

}

- (void)showViewAnimationWithView:(UIView *)view1 view2:(UIView *)view2 view3:(UIView *)view3 view4:(UIView *)view4{
    float autoheight     = CGRectGetHeight(view2.frame);
    float showViewHeight = selfHeight + autoheight;
    [UIView animateWithDuration:0.25 animations:^{
        view1.frame = FRAME(0, height - showViewHeight, width, showViewHeight);
        view2.frame = FRAME(0 , selfHeight, width, autoheight);
        view3.frame = FRAME(0, showViewHeight + height, width, CGRectGetHeight(view3.frame));
        view4.frame = FRAME(0, showViewHeight + height, width, CGRectGetHeight(view4.frame));
    }];
}
//动画显示结束
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark --初始化位置
///////////////////////////////////////////////////////////////////////////////////////////////////
/*****************************************
 *  @author null, 15-11-18 15:11:59
 *
 *  @brief  非聊天初始化按钮位置坐标
 *
 *  @since 1.0
 ****************************************/
- (void)setOtherBtnOriginFrame {
    _leftbtn.frame                  = FRAME(0, selfHeight - 44, 44, 44);
    _bginputview.frame              = FRAME(CGRectGetMaxX(_leftbtn.frame),
                                            4,
                                            width - CGRectGetMaxX(_leftbtn.frame) - 5,
                                            36);
    _bginputview.layer.cornerRadius = CGRectGetHeight(_bginputview.frame) / 2;
    _midbtn.frame                   = FRAME(CGRectGetWidth(_bginputview.frame) - 36, selfHeight - 44, 36, 36);
    _inputview.frame                = FRAME(5, selfHeight - 44, CGRectGetMinX(_midbtn.frame) - 3, 36);
    _keyboardbtn.frame              = FRAME(0, selfHeight - 44, 44, 44);
}
/*****************************************
 *  @author null, 15-11-18 15:11:20
 *
 *  @brief  阅后即焚初始化按钮坐标
 *
 *  @since 1.0
 ****************************************/
- (void)setBurnChatBtnOriginFrame {
    _closeBurnBtn.frame             = FRAME(width - 44, selfHeight - 44, 44, 44);
    _rightbtn.frame                 = FRAME(width - CGRectGetMinX(_closeBurnBtn.frame), selfHeight - 44, 44, 44);
    _leftbtn.frame                  = FRAME(0, selfHeight - 44, 44, 44);
    _bginputview.frame              = FRAME(CGRectGetMaxX(_leftbtn.frame),
                                            4,
                                            CGRectGetMinX(_rightbtn.frame) - CGRectGetMaxX(_leftbtn.frame),
                                            36);
    _bginputview.layer.cornerRadius = CGRectGetHeight(_bginputview.frame) / 2;
    _inputview.frame                = FRAME(5, selfHeight - 44, CGRectGetWidth(_bginputview.frame) - 3, 36);
    _keyboardbtn.frame              = FRAME(0, selfHeight - 44, 44, 44);
}
/*****************************************
 *  @author null, 15-11-18 14:11:15
 *
 *  @brief  正常情况下button按钮位置，聊天状态下按钮位置
 *
 *  @since
 ****************************************/
- (void)setCustomChatBtnOriginFrame {
    _rightbtn.frame                 = FRAME(width - 44, selfHeight - 44, 44, 44);
    _leftbtn.frame                  = FRAME(0, selfHeight - 44, 44, 44);
    _bginputview.frame              = FRAME(CGRectGetMaxX(_leftbtn.frame),
                                           4,
                                           CGRectGetMinX(_rightbtn.frame) - CGRectGetMaxX(_leftbtn.frame),
                                           36);
    _bginputview.layer.cornerRadius = CGRectGetHeight(_bginputview.frame) / 2;
    _midbtn.frame                   = FRAME(CGRectGetWidth(_bginputview.frame) - 36, selfHeight - 44, 36, 36);
    _inputview.frame                = FRAME(5, selfHeight - 44, CGRectGetMinX(_midbtn.frame) - 3, 36);
    _keyboardbtn.frame              = FRAME(0, selfHeight - 44, 44, 44);
}
///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark --初始化按钮图片和颜色
/*****************************************
 *  @author null, 15-11-18 15:11:38
 *
 *  @brief  非聊天按钮图片
 *
 *  @since 1.0
 ****************************************/
- (void)setOtherBtnImage {
    [self setBtnImg:@"tool_bar_audio" Withbtn:_leftbtn];
    [self setBtnImg:@"tool_bar_face" Withbtn:_midbtn];
    _bginputview.layer.borderColor   = COLOR(217, 215, 209, 1.0f).CGColor;
}
/*****************************************
 *  @author null, 15-11-18 15:11:05
 *
 *  @brief  阅后即焚按钮图片
 *
 *  @since 1.0
 ****************************************/
- (void)setBurnChatBtnImage {
    [self setBtnImg:@"burn_audiobtn" Withbtn:_leftbtn];
    [self setBtnImg:@"burn_imagebtn" Withbtn:_rightbtn];
    [self setBtnImg:@"burn_closebtn" Withbtn:_closeBurnBtn];
    _bginputview.layer.borderColor   = COLOR(217, 215, 209, 1.0f).CGColor;
}
/*****************************************
 *  @author null, 15-11-06 17:11:38
 *
 *  @brief  原始按钮图片
 *
 *  @since  1.0
 ****************************************/
- (void)setCustomChatBtnImage {
    [self setBtnImg:@"tool_bar_audio" Withbtn:_leftbtn];
    [self setBtnImg:@"tool_bar_face" Withbtn:_midbtn];
    [self setBtnImg:@"tool_bar_more" Withbtn:_rightbtn];
    [self setBtnImg:@"tool_bar_keyboard" Withbtn:_keyboardbtn];
    _bginputview.layer.borderColor   = COLOR(217, 215, 209, 1.0f).CGColor;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark --其他按钮设定
/*****************************************
 *  @author null, 15-11-06 17:11:57
 *
 *  @brief  按英文意思来
 *
 *  @since
 ****************************************/
- (void)setAllBtnHiddenIsNO {
    _leftbtn.hidden     = NO;
    _midbtn.hidden      = NO;
    _rightbtn.hidden    = NO;
    _keyboardbtn.hidden = NO;
}

/*****************************************
 *  @author null, 15-11-06 17:11:33
 *
 *  @brief  同上
 *
 *  @param imgname
 *  @param btn
 *
 *  @since
 ****************************************/
- (void)setBtnImg:(NSString *)imgname Withbtn:(UIButton *)btn {
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
}

- (void)btnclick:(UIButton *)btn {
    showUIType = (int)btn.tag;
    if (isBurnStatus) {
        [self setBurnChatBtnImage];
    } else {
        [self setCustomChatBtnImage];
    }

    [self setAllBtnHiddenIsNO];

    switch (btn.tag) {
        case AUDIO:
        {
            [btn setHidden:YES];
            
            [_inputview resignFirstResponder];
            [_keyboardbtn setFrame:btn.frame];
            [self showCihiBottomAudio];
        }
            break;
        case FACE:
        {
            [btn setHidden:YES];
            
            [_inputview resignFirstResponder];
            CGRect frame = [_bginputview convertRect:btn.frame toView:self];
            [_keyboardbtn setFrame:frame];
            [self showCihiBottomFace];
        }
            break;
        case TEXT:
        {
            [btn setHidden:YES];
            [_inputview becomeFirstResponder];
            
        }
            break;
        default:
        {
            [_inputview resignFirstResponder];
            [_keyboardbtn setHidden:YES];
            [self showCihiBottomAdtion];
        }
            break;
    }
}
#pragma mark 动画标签
/*****************************************
 *  @author null, 15-11-07 10:11:49
 *
 *  @brief  自动动画，text动画
 *
 *  @param hight
 *
 *  @since
 ****************************************/
- (void)showAnimation:(CGFloat)hight
{
    [UIView animateWithDuration:0.24 animations:^{
        [self setAnimationFrame:_bginputview WithHight:hight];
        [self setAnimationFrame:_inputview WithHight:hight];
        _leftbtn.center      = CGPointMake(_leftbtn.center.x, 22 + hight);
        _midbtn.center       = CGPointMake(_midbtn.center.x, 18 + hight);
        _rightbtn.center     = CGPointMake(_rightbtn.center.x, 22 + hight);
        _keyboardbtn.center  = CGPointMake(_keyboardbtn.center.x, 22 + hight);

        _closeBurnBtn.center = CGPointMake(_closeBurnBtn.center.x, 22 + hight);

        selfHeight           = 44 + KEYBOARDHEIGHT + hight;
        self.frame           = CGRectMake(CGRectGetMinX(self.frame),
                                          height - selfHeight,
                                          CGRectGetWidth(self.frame),
                                          selfHeight);
    }];
}

- (void)setAnimationFrame:(UIView *)view WithHight:(CGFloat)hight{
    view.frame = CGRectMake(CGRectGetMinX(view.frame),
                            CGRectGetMinY(view.frame),
                            CGRectGetWidth(view.frame),
                            36 + hight);
}

#pragma mark --阅后即焚
- (void)showBurnStatus {
    isBurnStatus = YES;
    [self showCihiBottomViewOnly];
    [self setBurnChatBtnOriginFrame];
    [self setBurnChatBtnImage];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

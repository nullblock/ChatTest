//
//  CihiBottomView.m
//  ChatTest
//
//  Created by null on 11/6/15.
//  Copyright © 2015 null. All rights reserved.
//

#import "CihiBottomView.h"
#import "CihiTextView.h"

#import "CihiBottomAudioView.h"
#import "CihiBottomFaceView.h"
#import "CihiBottomAddtionView.h"

@interface CihiBottomView() <CihiTextViewDelegate>

@end

@implementation CihiBottomView
{
    float width;                //宽
    float height;               //高
    
    CGFloat selfHeight;           //44
    
    UIButton *_leftbtn;         //左边按钮
    UIButton *_midbtn;          //中间按钮
    UIButton *_rightbtn;        //右边按钮
    UIButton *_keyboardbtn;     //键盘按钮
    CihiTextView *_inputview;   //输入框
    UIView *_bginputview;       //输入框背景
    
    CihiBottomAudioView *audioView;     //语音按钮
    CihiBottomFaceView *faceView;       //表情列表
    CihiBottomAddtionView *addtionView; //附加列表
    
    BOOL isShowKeyBorard;           //是否显示键盘
    
    float KEYBOARDHEIGHT;     //键盘高度
}

@synthesize showtype;
@synthesize control;

- (id)init {
    self = [super init];
    if (self) {
        width = CGRectGetWidth([UIScreen mainScreen].bounds);
        height = CGRectGetHeight([UIScreen mainScreen].bounds);
        selfHeight = 44;
        float y = height - selfHeight;
        [self setFrame:CGRectMake(0, y, width, selfHeight)];
        [self addview];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (void)keyboardWillShow:(NSNotification *)notifacation {
    isShowKeyBorard = YES;
    [self setAllBtnHiddenIsNO];
    [_keyboardbtn setHidden:YES];
    NSDictionary *dic = notifacation.userInfo;
    NSValue *value = [dic objectForKey:UIKeyboardFrameBeginUserInfoKey];
    KEYBOARDHEIGHT = CGRectGetHeight(value.CGRectValue);
    [self showViewAnimationWithView:self WithFrame:CGRectMake(0, height - selfHeight - KEYBOARDHEIGHT, width, selfHeight)];
}

- (void)keyboardWillHide:(NSNotification *)notifacation {
    isShowKeyBorard = NO;
    KEYBOARDHEIGHT = 0;
}

- (void)showCihiBottomAudio {
    if (audioView == nil) {
        audioView = [[CihiBottomAudioView alloc]init];
        [audioView setBackgroundColor:[UIColor whiteColor]];
        audioView.control = control;
        [audioView addAllScroller];
        [audioView addPageControlView];
        [self addSubview:audioView];
    }
    float autoheight = CGRectGetHeight(audioView.frame);
    
    [UIView animateWithDuration:0.25 animations:^{

        [self showViewAnimationWithView:self WithFrame:CGRectMake(0, height - selfHeight - autoheight, width, selfHeight + autoheight)];
        
        [self showViewAnimationWithView:audioView WithFrame:CGRectMake(0, selfHeight, width, autoheight)];
        [self showViewAnimationWithView:faceView WithFrame:CGRectMake(0, selfHeight + autoheight, width, CGRectGetHeight(faceView.frame))];
        [self showViewAnimationWithView:addtionView WithFrame:CGRectMake(0, selfHeight + autoheight, width, CGRectGetHeight(addtionView.frame))];
        
    }];
}

- (void)showCihiBottomFace {
    if (faceView == nil) {
        faceView = [[CihiBottomFaceView alloc]init];
        [faceView setBackgroundColor:[UIColor brownColor]];
        faceView.control = control;
        [self addSubview:faceView];
    }
    
    float autoheight = CGRectGetHeight(faceView.frame);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self showViewAnimationWithView:self WithFrame:CGRectMake(0, height - selfHeight - autoheight, width, selfHeight + autoheight)];
        
        [self showViewAnimationWithView:faceView WithFrame:CGRectMake(0, selfHeight, width, autoheight)];
        [self showViewAnimationWithView:audioView WithFrame:CGRectMake(0, selfHeight + autoheight, width, CGRectGetHeight(audioView.frame))];
        [self showViewAnimationWithView:addtionView WithFrame:CGRectMake(0, selfHeight + autoheight, width, CGRectGetHeight(addtionView.frame))];
    }];
}

- (void)showCihiBottomAdtion {
    if (addtionView == nil) {
        addtionView = [[CihiBottomAddtionView alloc]init];
        [addtionView setBackgroundColor:[UIColor cyanColor]];
        addtionView.control = control;
        [self addSubview:addtionView];
    }

    float autoheight = CGRectGetHeight(addtionView.frame);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self showViewAnimationWithView:self WithFrame:CGRectMake(0, height - selfHeight - autoheight, width, selfHeight + autoheight)];
        
        [self showViewAnimationWithView:addtionView WithFrame:CGRectMake(0, selfHeight, width, autoheight)];
        [self showViewAnimationWithView:faceView WithFrame:CGRectMake(0, selfHeight + autoheight, width, CGRectGetHeight(faceView.frame))];
        [self showViewAnimationWithView:audioView WithFrame:CGRectMake(0, selfHeight + autoheight, width, CGRectGetHeight(audioView.frame))];
        
    }];
}

- (void)showViewAnimationWithView:(UIView *)view WithFrame:(CGRect)frame {
    [view setFrame:frame];
}

/*****************************************
 *  @author null, 15-11-06 13:11:45
 *
 *  @brief  添加view
 *
 *  @since v1.0
 ****************************************/
- (void)addview
{
    //添加最右边按钮
//    _rightbtn = [[UIButton alloc]initWithFrame:CGRectMake(width - 44, 0, 44, 44)];
//    [_rightbtn setImage:[UIImage imageNamed:@"tool_bar_more"] forState:UIControlStateNormal];
//    [self addSubview:_rightbtn];
    
    _rightbtn = [self setBtn:_rightbtn WithTag:ADDTION WithFrame:CGRectMake(width - 44, 0, 44, 44)];
    [self addSubview:_rightbtn];
    
    //添加最左边按钮
//    _leftbtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [_leftbtn setImage:[UIImage imageNamed:@"tool_bar_audio"] forState:UIControlStateNormal];
//    [self addSubview:_leftbtn];
    
    _leftbtn = [self setBtn:_leftbtn WithTag:AUDIO WithFrame:CGRectMake(0, 0, 44, 44)];
    [self addSubview:_leftbtn];
    
    //添加文字输入设备背景层
    _bginputview = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftbtn.frame), 4, CGRectGetMinX(_rightbtn.frame) - CGRectGetMaxX(_leftbtn.frame), 36)];
    [_bginputview.layer setMasksToBounds:YES];
    [_bginputview.layer setCornerRadius:CGRectGetHeight(_bginputview.frame)/2];
    [_bginputview.layer setBorderWidth:0.5f];
    [_bginputview.layer setBorderColor:[UIColor colorWithRed:217/255.0f green:215/255.0f blue:209/255.0f alpha:1.0f].CGColor];
    [self addSubview:_bginputview];
    
    //表情按钮
//    _midbtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(_bginputview.frame) - 36, 0, 36, 36)];
//    [_midbtn setImage:[UIImage imageNamed:@"tool_bar_face"] forState:UIControlStateNormal];
//    [_bginputview addSubview:_midbtn];
    
    _midbtn = [self setBtn:_midbtn WithTag:FACE WithFrame:CGRectMake(CGRectGetWidth(_bginputview.frame) - 36, 0, 36, 36)];
    [_bginputview addSubview:_midbtn];
    
    //文字输入设备
    _inputview = [[CihiTextView alloc]initWithFrame:CGRectMake(5, 0, CGRectGetMinX(_midbtn.frame) - 3, 36)];
    _inputview.font = [UIFont systemFontOfSize:16.5f];
    [_inputview setCihiDelegate:self];
    [_bginputview addSubview:_inputview];
    
    
    //键盘按钮
    _keyboardbtn = [self setBtn:_keyboardbtn WithTag:TEXT WithFrame:CGRectMake(0, 0, 44, 44)];
    [_keyboardbtn setHidden:YES];
    [self addSubview:_keyboardbtn];
    
    //初始化所有按钮图片
    [self setAllOriginBtnImagename];
}

/*****************************************
 *  @author null, 15-11-06 14:11:30
 *
 *  @brief  初始化btn
 *
 *  @param btn
 *  @param tag
 *  @param frame
 *  @param imgname
 *
 *  @return
 *
 *  @since
 ****************************************/
- (UIButton *)setBtn:(UIButton *)btn WithTag:(NSInteger)tag WithFrame:(CGRect)frame {
    btn = [[UIButton alloc]init];
    [self setBtnFrame:frame Withbtn:btn];
    [btn setTag:tag];
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setAllOriginBtnFrame {
    
}

/*****************************************
 *  @author null, 15-11-06 17:11:38
 *
 *  @brief  原始按钮图片
 *
 *  @since
 ****************************************/
- (void)setAllOriginBtnImagename {
    [self setBtnImg:@"tool_bar_audio" Withbtn:_leftbtn];
    [self setBtnImg:@"tool_bar_face" Withbtn:_midbtn];
    [self setBtnImg:@"tool_bar_more" Withbtn:_rightbtn];
    [self setBtnImg:@"tool_bar_keyboard" Withbtn:_keyboardbtn];
}

/*****************************************
 *  @author null, 15-11-06 17:11:57
 *
 *  @brief  按英文意思来
 *
 *  @since
 ****************************************/
- (void)setAllBtnHiddenIsNO {
    [_leftbtn setHidden:NO];
    [_midbtn setHidden:NO];
    [_rightbtn setHidden:NO];
    [_keyboardbtn setHidden:NO];
}

/*****************************************
 *  @author null, 15-11-06 17:11:13
 *
 *  @brief  没事就像整合一下
 *
 *  @param frame
 *  @param btn
 *
 *  @since
 ****************************************/
- (void)setBtnFrame:(CGRect)frame Withbtn:(UIButton *)btn {
    [btn setFrame:frame];
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
    showtype = (int)btn.tag;
    
    [self setAllOriginBtnImagename];
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

/*****************************************
 *  @author null, 15-11-06 17:11:45
 *
 *  @brief  和上边的是一起的
 *
 *  @param btn
 *
 *  @since
 ****************************************/
- (void)left_mid_keyboardClick:(UIButton *)btn
{
    
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
        [_leftbtn setCenter:CGPointMake(_leftbtn.center.x, 22 + hight)];
        [_midbtn setCenter:CGPointMake(_midbtn.center.x, 18 + hight)];
        [_rightbtn setCenter:CGPointMake(_rightbtn.center.x, 22 + hight)];
        [_keyboardbtn setCenter:CGPointMake(_keyboardbtn.center.x, 22 + hight)];
        selfHeight = 44 + KEYBOARDHEIGHT + hight;
        [self setFrame:CGRectMake(CGRectGetMinX(self.frame), height - selfHeight, CGRectGetWidth(self.frame), selfHeight)];
    }];
}

- (void)setAnimationFrame:(UIView *)view WithHight:(CGFloat)hight{
    [view setFrame:CGRectMake(CGRectGetMinX(view.frame), CGRectGetMinY(view.frame), CGRectGetWidth(view.frame), 36 + hight)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

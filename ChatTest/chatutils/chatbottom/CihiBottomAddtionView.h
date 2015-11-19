//
//  CihiBottomAddtionView.h
//  ChatTest
//
//  Created by null on 11/10/15.
//  Copyright © 2015 null. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BTNTAGVALUE) {
    PHOTOGRAPH = 0, //拍照
    PHOTOALBUM,     //相册
    BURNSTATUS,     //阅后即焚
    LOCATION,       //位置
    GIFT,           //礼物
};

@protocol CihiBottomAddtionViewDelegate
//点击按钮 tag
- (void)addtionViewBtnClick:(BTNTAGVALUE)tag;

@end

@interface CihiBottomAddtionView : UIView

@property (nonatomic, assign) UIViewController *control;
@property (nonatomic, assign) id<CihiBottomAddtionViewDelegate> deleg;
///////////////////////////////////////////////////////////////////////////////////////////////////
//商家弹出的附加面板
- (CGRect)setBusinessBtnInfos;
//官方消息弹出的面板
- (CGRect)setOfficialBtnInfos;
//普通消息弹出的面板
- (CGRect)setCustomBtnInfos;
///////////////////////////////////////////////////////////////////////////////////////////////////
@end

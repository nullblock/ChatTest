//
//  CihiBottomView.h
//  ChatTest
//
//  Created by null on 11/6/15.
//  Copyright © 2015 null. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AUDIO   = 101,//左边按钮
    FACE    = 102,//中间按钮
    ADDTION = 103,//右边按钮
    TEXT    = 104,//键盘按钮
}ISSHOWTYPE;

@interface CihiBottomView : UIView

@property (nonatomic, assign) ISSHOWTYPE showtype;  //当前显示的是
@property (nonatomic, assign) UIViewController *control; //添加的界面

@end

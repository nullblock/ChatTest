//
//  CihiBottomFaceView.h
//  ChatTest
//
//  Created by null on 11/9/15.
//  Copyright © 2015 null. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CihiBottomFaceView : UIView<UIScrollViewDelegate>

@property (nonatomic, assign) UIViewController *control;

- (void)getSFaceView;

@end

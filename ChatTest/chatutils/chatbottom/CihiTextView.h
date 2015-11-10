//
//  CihiTextView.h
//  ChatTest
//
//  Created by null on 11/6/15.
//  Copyright © 2015 null. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CihiTextViewDelegate

- (void)showAnimation:(CGFloat)hight;

@end

@interface CihiTextView : UITextView

@property (nonatomic, assign) id<CihiTextViewDelegate> cihiDelegate;

@end

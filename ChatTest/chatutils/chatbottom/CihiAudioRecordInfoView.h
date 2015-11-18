//
//  CihiAudioRecordInfoView.h
//  ChatTest
//
//  Created by null on 11/18/15.
//  Copyright © 2015 null. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CihiAudioRecordInfoViewDelegate

- (void)stopAudioRecordInfoWithNum;

@end

@interface CihiAudioRecordInfoView : UIView

@property (nonatomic, assign) id<CihiAudioRecordInfoViewDelegate> deleg;

- (void)setTapFrame;
- (void)setLongPressFrame;

- (void)startMessage;
- (void)stopMessage;
@end

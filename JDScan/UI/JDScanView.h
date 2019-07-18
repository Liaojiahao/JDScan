//
//  JDScanView.h
//  JDScanner
//
//  Created by WJD on 19/4/3.
//  Copyright © 2019 年 WJD. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "JDScanAnimation.h"
#import "JDScanViewStyle.h"

/**
 扫码区域显示效果
 */
@interface JDScanView : UIView

/**
 扫描区域的rect
 */
@property (nonatomic, assign, readonly) CGRect scanRect;

/**
 @brief  初始化
 @param frame 位置大小
 @param style 类型

 @return instancetype
 */
- (id)initWithFrame:(CGRect)frame style:(JDScanViewStyle*)style;

/**
 *  设备启动中文字提示
 */
- (void)startDeviceReadyingWithText:(NSString*)text;

/**
 *  设备启动完成
 */
- (void)stopDeviceReadying;

/**
 *  开始扫描动画
 */
- (void)startScanAnimation;

/**
 *  结束扫描动画
 */
- (void)stopScanAnimation;

/**
 @brief  根据矩形区域，获取Native扫码识别兴趣区域
 @param view  视频流显示UIView
 @param scanRect 扫描的区域
 @return 识别区域
 */
+ (CGRect)getScanRectWithPreView:(UIView*)view scanRect:(CGRect)scanRect;

/**
 根据矩形区域，获取ZXing库扫码识别兴趣区域

 @param view 视频流显示视图
 @param scanRect 扫描的区域
 @return 识别区域
 */
+ (CGRect)getZXingScanRectWithPreView:(UIView*)view scanRect:(CGRect)scanRect;

@end

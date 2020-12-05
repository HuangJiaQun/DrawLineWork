//
//  LF_drawLineChart.h
//  DrawLineWork
//
//  Created by 黄嘉群 on 2020/5/23.
//  Copyright © 2020 黄嘉群. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LF_drawLineChart : UIView
/*
 横坐标数组
 */
@property (nonatomic,strong)NSArray*horizationDateArray;
/*
 竖坐标数组
 */
@property (nonatomic,strong)NSArray*verticalDateArray;

/**
 *  需要展示的N组数据
*/
@property (nonatomic,strong)NSArray*dataArray;
/**
 *  线条的颜色
 */
@property (nonatomic,strong)NSArray*lineColorArray;
/**
 *  每条线条代表什么
 */
@property (nonatomic,strong)NSArray*titleArray;
/**
 *  绘制X、Y值 、虚线、折线
 */
- (void)drawLineDashWithHorizontalDateArray:(NSArray *)horizontalDateArray VerticalDateArray:(NSArray *)verticalDateArray SourceData:(NSArray *)dataArray;


@end

NS_ASSUME_NONNULL_END

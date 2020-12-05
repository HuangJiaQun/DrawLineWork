//
//  LF_drawLineChart.m
//  DrawLineWork
//
//  Created by 黄嘉群 on 2020/5/23.
//  Copyright © 2020 黄嘉群. All rights reserved.
//

#import "LF_drawLineChart.h"

static CGFloat bounceX = 30;
static CGFloat bounceY = 40;

@interface LF_drawLineChart()<CAAnimationDelegate>
@property (nonatomic,strong)UIView*gradientBackgroundView;//展示折线的背景
@end

@implementation LF_drawLineChart




- (void)drawRect:(CGRect)rect{
    //    /*******画出坐标轴********/
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);//设置g宽度
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);////设置颜色
    CGContextMoveToPoint(context, bounceX, 0);//设置线段起点坐标。
    NSLog(@"%.1f %.1f",rect.size.height,rect.size.width);
    CGContextAddLineToPoint(context, bounceX, rect.size.height-bounceY);//添加线段
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-bounceY);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawLineDashWithHorizontalDateArray:(NSArray *)horizontalDateArray VerticalDateArray:(NSArray *)verticalDateArray SourceData:(NSArray *)dataArray{
    self.horizationDateArray=horizontalDateArray;
    self.verticalDateArray=verticalDateArray;
    self.dataArray=dataArray;
    [self setNeedsLayout];
}
#pragma mark --- 创建x轴的数据
- (void)createLabelX{
    CGFloat xCount=self.horizationDateArray.count;
    for (NSInteger i=0; i<self.horizationDateArray.count; i++) {
        CGFloat widthlable=(self.frame.size.width-bounceX)/xCount;//每个数据的宽。
        CGFloat heightlable=bounceY;
        UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - bounceX)/xCount * i + bounceX, self.frame.size.height - bounceY+bounceX/4.0, widthlable, heightlable-bounceX/4.0)];
        LabelMonth.textAlignment = NSTextAlignmentCenter;
        LabelMonth.tag = 1000 + i;
        LabelMonth.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
        LabelMonth.text=self.horizationDateArray[i];
        LabelMonth.font=[UIFont systemFontOfSize:14];
        LabelMonth.numberOfLines = 0;
        LabelMonth.lineBreakMode = 0;
        [self addSubview:LabelMonth];
    }
}

#pragma mark 创建y轴数据
- (void)createLabelY{
    CGFloat Ydivision = self.verticalDateArray.count-1;
    for (NSInteger i = 0; i < self.verticalDateArray.count ; i++) {
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.frame.size.height -  bounceY)/Ydivision *i, bounceX, bounceX/2.0)];
        labelYdivision.tag = 2000 + i;
        labelYdivision.textColor = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
        labelYdivision.text = [NSString stringWithFormat:@"%@",self.verticalDateArray[i]];
        labelYdivision.font = [UIFont systemFontOfSize:10];
        [self addSubview:labelYdivision];
    }
}

#pragma mark --- 传添加虚线
- (void)setLineDash{
    self.gradientBackgroundView =[[UIView alloc] initWithFrame:CGRectMake(bounceX, 0, self.bounds.size.width - bounceX, self.bounds.size.height - bounceY+bounceX/4.0)];
    [self addSubview:self.gradientBackgroundView];
    
    for (NSInteger i = 0;i < self.verticalDateArray.count; i++ ) {
        //CAShapeLayer是图形layer层，我们可以自定义这个层的形状。CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类。指定诸如颜色和线宽等属性，用CGPath来定义想要绘制的图形，最后CAShapeLayer就自动渲染出来了。当然，也可以用Core Graphics直接向原始的CALyer的内容中绘制一个路径，相比之下，使用CAShapeLayer有以下一些优点：
        
        //        渲染快速。CAShapeLayer使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
        //        高效使用内存。一个CAShapeLayer不需要像普通CALayer一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
        //        不会被图层边界剪裁掉。一个CAShapeLayer可以在边界之外绘制。图层路径不会像在使用Core Graphics的普通CALayer一样被剪裁掉。
        //        不会出现像素化。当把CAShapeLayer放大，或是用3D透视变换将其离相机更近时，它不像一个有寄宿图的普通图层一样变得像素化。
        //        CAShapeLayer可以用来绘制所有能够通过CGPath来表示的形状。这个形状不一定要闭合，图层路径也不一定要不间断的，事实上可以在一个图层上绘制好几个不同的形状。
        
        CAShapeLayer * dashLayer = [CAShapeLayer layer];
        dashLayer.strokeColor = [UIColor colorWithRed:222/255.0 green:223/255.0 blue:224/255.0 alpha:1].CGColor;//// 边框颜色
        dashLayer.fillColor = [[UIColor clearColor] CGColor];//// 路径的填充颜色
        // 默认设置路径宽度为0，使其在起始状态下不显示
        dashLayer.lineWidth = 1.0;
        // 拐点样式（lineJoin）
        UILabel * label1 = (UILabel*)[self viewWithTag:2000 + i];
        
        UIBezierPath * path = [[UIBezierPath alloc]init];
        path.lineWidth = 1.0;
        UIColor * color = [UIColor whiteColor];
        
        [color set];
        [path moveToPoint:CGPointMake( 0, label1.frame.origin.y+label1.frame.size.height*0.5)];//路径起点// 添加路径起点
        [path addLineToPoint:CGPointMake(self.frame.size.width - bounceX,label1.frame.origin.y+label1.frame.size.height*0.5)];//线段// 添加直线到另外一个点
        CGFloat dash[] = {2,2};
        [path setLineDash:dash count:2 phase:10];
        [path stroke];
        
        dashLayer.path = path.CGPath;
        dashLayer.lineDashPattern=[NSArray arrayWithObjects:[NSNumber numberWithInt:1],
                                   [NSNumber numberWithInt:2],nil];//线模版（lineDashPattern）
        //这句话的意思是说这个虚线由四部分组成：
        //        第一段实线长度为1
        //        画完长度为1像素的实线之后，空2像素
        //        然后重复这个数组中的数值，一直不停的绘画。
        
        [self.gradientBackgroundView.layer addSublayer:dashLayer];
        
    }
}









@end

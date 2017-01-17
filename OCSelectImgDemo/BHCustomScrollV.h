//
//  BHCustomScrollV.h
//  OCSelectImgDemo
//
//  Created by healthmanage on 17/1/13.
//  Copyright © 2017年 healthmanager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+AFNetworking.h"

@class BHCustomScrollV;
@protocol BHCustomScrollVBtnDelegate <NSObject>

-(void)BHCustomScrollVSelectBtn:(UIButton *)btn;

@end

@interface BHCustomScrollV : UIView
{
    //设计item大小,中间比两边的宽、高各大30，间距为10，距离左右边界为30
    CGFloat itemWidthF;
    CGFloat itemHeightF;
    CGFloat bigItemWidthF;
    CGFloat bigItemHeightF;
    
    CGFloat xCenterF;//中心值
}
@property(nonatomic,strong)NSArray *imgArray;//图片数组
@property(nonatomic,strong)NSArray *titleArray;//文字数组
@property(nonatomic,assign)CGRect frameE;//视图大小
@property(nonatomic,assign)NSInteger currentInt;//当前在中间的tag值

@property(nonatomic,strong)UIScrollView *bgScrollV;//滑动背景

//创建一个全局按钮
//@property(nonatomic,strong)UIButton *midlleBtn;//中间按钮
@property(nonatomic,weak)id <BHCustomScrollVBtnDelegate>delegate;

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)aImgArr titleArray:(NSArray *)aTitleArr;

@end

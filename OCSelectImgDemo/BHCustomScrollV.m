//
//  BHCustomScrollV.m
//  OCSelectImgDemo
//
//  Created by healthmanage on 17/1/13.
//  Copyright © 2017年 healthmanager. All rights reserved.
//

#import "BHCustomScrollV.h"

@implementation BHCustomScrollV

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame imgArray:(NSArray *)aImgArr titleArray:(NSArray *)aTitleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        _frameE = frame;
        _imgArray = aImgArr;
        _titleArray = aTitleArr;
        
        [self addSubview:self.bgScrollV];
    }
    return self;
}
-(UIScrollView *)bgScrollV
{
    _bgScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _frameE.size.width, _frameE.size.height)];
    _bgScrollV.bounces = NO;
    _bgScrollV.showsHorizontalScrollIndicator = NO;
    [_bgScrollV setScrollEnabled:NO];
    //添加item视图
    [self addItemViewWithArray:_imgArray titleArray:_titleArray];
    
    return _bgScrollV;
}
-(void)addItemViewWithArray:(NSArray *)imgArr titleArray:(NSArray *)titleArr
{
    //这里因为我要保证屏幕上至少能够出现三个完整的，两边两个部分内容，所以我写了4
    if (_imgArray.count<4) {
        return;
    }
    //设计item大小,中间比两边的宽、高各大30，间距为10，距离左右边界为30
    itemWidthF = (_frameE.size.width-30*2-30-20)/3;
    itemHeightF = _frameE.size.height-30;
    bigItemWidthF = itemWidthF+30;
    bigItemHeightF = itemHeightF+30;
    
    //中心值
    xCenterF = _frameE.size.width/2.0;
    
    //创建新的数组
    NSMutableArray *newImgArr = [NSMutableArray new];
    NSMutableArray *newTitleArr = [NSMutableArray new];
    for (int i = 0; i < imgArr.count+4; i++) {
        if (i < 2) {//0,1
            [newImgArr addObject:imgArr[imgArr.count+i-2]];
            [newTitleArr addObject:titleArr[titleArr.count+i-2]];
        }else if(i >= 2 && i < imgArr.count+2){//2,3,.....(imgArr.count-1)
            [newImgArr addObject:imgArr[i-2]];
            [newTitleArr addObject:titleArr[i-2]];
        }else{
            [newImgArr addObject:imgArr[i-imgArr.count-2]];
            [newTitleArr addObject:titleArr[i-imgArr.count-2]];
        }
    }
    
    //记录数组数量
    NSInteger totalNum = newImgArr.count;
    for (int i = 0; i < totalNum; i++) {
        
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [bgBtn setTitle:newTitleArr[i] forState:UIControlStateNormal];
        [bgBtn setBackgroundColor:[UIColor blueColor]];
        bgBtn.layer.cornerRadius = 5;
        bgBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bgBtn.layer.borderWidth = 1.0;
        [bgBtn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:newImgArr[i]] placeholderImage:[UIImage imageNamed:@""]];
        [bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        bgBtn.userInteractionEnabled = NO;
        if (i == 2) {
            bgBtn.frame = CGRectMake(30+(itemWidthF+10)*i, 0, bigItemWidthF, bigItemHeightF);
            bgBtn.userInteractionEnabled = YES;
            
            [_bgScrollV setContentOffset:CGPointMake(((30+(itemWidthF+10)*i)+bigItemWidthF/2)-xCenterF, 0) animated:YES];
            
            _currentInt = i;
            
        }else if(i>2){
            bgBtn.frame = CGRectMake(30+(itemWidthF+10)*i+30, 15, itemWidthF, itemHeightF);
        }else{
            bgBtn.frame = CGRectMake(30+(itemWidthF+10)*i, 15, itemWidthF, itemHeightF);
        }
        
        bgBtn.tag = i+100;
        
        [_bgScrollV addSubview:bgBtn];
        
    }
    _bgScrollV.contentSize = CGSizeMake((itemWidthF+10)*totalNum+30+30*2, bigItemHeightF);
    
    [self addgesture];
}
//按钮点击
//这个地方会出现两种效果，一种是：只有在中间的才可以点击，其他的不可以；一种是：都可以点击，并且点击到哪一个按钮，这个按钮就跳转到中间。我现在要实现的是第一种情况，第二种比较复杂,需要判断方向
-(void)bgBtnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(BHCustomScrollVSelectBtn:)]) {
        [self.delegate BHCustomScrollVSelectBtn:btn];
    }
}
//添加左滑、右滑的手势
- (void)addgesture
{
    UISwipeGestureRecognizer *leftswipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(transitionPush:)];
    leftswipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [_bgScrollV addGestureRecognizer:leftswipe];
    
    UISwipeGestureRecognizer *rightswipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(transitionPush:)];
    rightswipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [_bgScrollV addGestureRecognizer:rightswipe];
    
}
//手势方法
-(void)transitionPush:(UISwipeGestureRecognizer *)swipeGes
{
    [UIView animateWithDuration:0.2 animations:^{
        UIButton *oldBtn = (UIButton *)[_bgScrollV viewWithTag:_currentInt+100];
        //取消旧按钮的交互
        oldBtn.userInteractionEnabled = NO;
        //NSLog(@"输出1111--------%ld",_currentInt);
        if (swipeGes.direction == UISwipeGestureRecognizerDirectionLeft){
            if (_currentInt==_imgArray.count+2-1) {
                NSLog(@"已经是最后一张了....");
                
                //回到最原始的位置,记录的是数组中的索引值
                _currentInt = 2;
                
                //变大的后面的按钮到最后一个的位置都变小
                for (int i = 3; i<_imgArray.count+2; i++) {
                    UIButton *allOldBtn = (UIButton *)[_bgScrollV viewWithTag:i+100];
                    allOldBtn.frame = CGRectMake(30+(itemWidthF+10)*i+30, 15, itemWidthF, itemHeightF);
                }
            }else{
                
                _currentInt = _currentInt+1;
                
                //旧的按钮变小,比下面的差了30的距离
                oldBtn.frame = CGRectMake(30+(itemWidthF+10)*(_currentInt-1), 15, itemWidthF, itemHeightF);
            }
            
        }
        if(swipeGes.direction == UISwipeGestureRecognizerDirectionRight){
            if (_currentInt==2) {
                NSLog(@"已经是第一张了....");
                
                //回到最后的位置，记录的是数组中的索引值
                _currentInt = _imgArray.count+2-1;
                
                //变大的后面的按钮到_currentInt==2的位置都变小
                for (int i = 2; i<_imgArray.count+2-1; i++) {
                    UIButton *allOldBtn = (UIButton *)[_bgScrollV viewWithTag:i+100];
                    allOldBtn.frame = CGRectMake(30+(itemWidthF+10)*i, 15, itemWidthF, itemHeightF);
                }
            }else{
                _currentInt = _currentInt-1;
                
                //旧的按钮变小
                oldBtn.frame = CGRectMake(30+(itemWidthF+10)*(_currentInt+1)+30, 15, itemWidthF, itemHeightF);
            }
        }
        
        //新的变大
        UIButton *newBtn = (UIButton *)[_bgScrollV viewWithTag:_currentInt+100];
        newBtn.frame = CGRectMake(30+(itemWidthF+10)*_currentInt, 0, bigItemWidthF, bigItemHeightF);
        //添加新按钮的交互
        newBtn.userInteractionEnabled = YES;
        
        [_bgScrollV setContentOffset:CGPointMake(((30+(itemWidthF+10)*_currentInt)+bigItemWidthF/2)-xCenterF, 0) animated:YES];
        
        //NSLog(@"输出2222--------%ld",_currentInt);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

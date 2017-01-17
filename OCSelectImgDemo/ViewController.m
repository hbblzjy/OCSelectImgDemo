//
//  ViewController.m
//  OCSelectImgDemo
//
//  Created by healthmanage on 17/1/13.
//  Copyright © 2017年 healthmanager. All rights reserved.
//

#import "ViewController.h"
#import "BHCustomScrollV.h"

#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<BHCustomScrollVBtnDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:
                            @"http://a.hiphotos.baidu.com/news/q%3D100/sign=f87b809725f5e0fee8188d016c6134e5/4610b912c8fcc3cecb9946bd9a45d688d53f20e6.jpg",
                            @"http://www.360xzl.com/uploadfile/2014/0503/20140503120443380.jpg",
                            @"http://pic38.huitu.com/res/20151012/362232_20151012131331161324_1.jpg",
                            @"http://cc.cocimg.com/api/uploads/160927/f215685e021da08f00688f6e55f99c61.jpg",
                            @"http://www.wpl.gov.cn/UploadFile/20110831101308958.jpg",
                            @"http://cc.cocimg.com/api/uploads/160912/fc340295b8ef4679f4e72250f03bd465.jpg",
                            @"http://cc.cocimg.com/api/uploads/160725/2b52353b034bbc9211b72dfa6a545987.jpg",
                            @"http://pic7.nipic.com/20100609/4478423_091730008695_2.jpg",
                            @"http://e.hiphotos.baidu.com/news/q%3D100/sign=80472f883bfa828bd72399e3cd1e41cd/aa18972bd40735fadab4e53496510fb30e2408f2.jpg",
                            @"http://img3.redocn.com/tupian/20140913/yanjiangdalou_3049217.jpg", nil];
    
    NSArray *titleArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    
    BHCustomScrollV *bhCSV = [[BHCustomScrollV alloc] initWithFrame:CGRectMake(0, 100, Screen_width, 200) imgArray:imgArr titleArray:titleArr];
    bhCSV.layer.borderWidth = 1.0;
    bhCSV.delegate = self;
    [self.view addSubview:bhCSV];
    
}
-(void)BHCustomScrollVSelectBtn:(UIButton *)btn
{
    NSLog(@"输出此时显示的按钮tag值。。。。。%ld",btn.tag);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

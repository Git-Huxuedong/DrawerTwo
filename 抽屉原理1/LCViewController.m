//
//  LCViewController.m
//  抽屉原理1
//
//  Created by Mac on 14-12-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "LCViewController.h"

@interface LCViewController ()
@property (nonatomic, strong) UIView *rigthView;
@property (nonatomic, strong) UIView *mainView;
@end

@implementation LCViewController

-(void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // rightView
    self.rigthView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.rigthView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.rigthView];
    


    // mainView
    self.mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.mainView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.mainView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor  = [UIColor  redColor];
   
}

#define kMaxOffsetY     60.0

/** 使用偏移x值计算主视图目标的frame */
- (CGRect)rectWithOffsetX:(CGFloat)x
{
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    // 1. 计算y
    CGFloat y = x * 60 / 320.0;
    // 2. 计算缩放比例
    CGFloat scale = (winSize.height - 2 * y) / winSize.height;
    
    // 如果 x<0 同样要缩小
    if (self.mainView.frame.origin.x < 0) {
        scale = 2 - scale;
    }
    
    // 3. 根据比例计算mainView新的frame
    CGRect frame = self.mainView.frame;
    // 3.1 宽度
    frame.size.width = frame.size.width * scale;
    frame.size.height = frame.size.height * scale;
    frame.origin.x += x;
    frame.origin.y = (winSize.height - frame.size.height) * 0.5;
    
    return frame;
}

// 拖动手指
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 记录是拖动的
  //  self.draging = YES;
    
    // 取出触摸
    UITouch *touch = touches.anyObject;
    
    // 1> 当前触摸点
    CGPoint location = [touch locationInView:self.view];
    // 2> 之前触摸点
    CGPoint pLocation = [touch previousLocationInView:self.view];
    // 计算水平偏移量
    CGFloat offsetX = location.x - pLocation.x;
    CGRect  frame  = self.mainView.frame;

    if (offsetX  > 0  && frame.origin.x  >= 0) {
        frame.origin.x  = 0;
    }
    
    else{
        
        if (offsetX   + 300 < 0) {
            
             frame.origin.x =  - 300;
        }else{
        
            frame.origin.x +=  offsetX;
        }
    }
    
    self.mainView.frame  = frame;

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (  0  - self.mainView.frame.origin.x  >=  self.view.frame.size.width  * 0.5) {
        CGRect  frame  = self.mainView.frame;
        frame.origin.x  =  - 300;
    
         self.mainView.frame  = frame;
    
    }
 
    if (  0  - self.mainView.frame.origin.x  <  self.view.frame.size.width  * 0.5) {
        CGRect  frame  = self.mainView.frame;
        frame.origin.x  =  0 ;
        
        self.mainView.frame  = frame;
        
    }
}

@end

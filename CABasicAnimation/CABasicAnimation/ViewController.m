//
//  ViewController.m
//  CABasicAnimation
//
//  Created by apple on 2016/11/19.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 Quartz2D、CALayer、CAAnimation的区别和主要用法：
 1、Quartz2D是一个二维绘图引擎，同时支持iOS和Mac系统。一般用于图形的绘制、图片的裁剪等。当使用Quartz2D时会牵涉到图形上下文(CGContextRef)以及贝塞尔路径(UIBezierPath)；
 2、CALayer是UIView内部的图层，可以利用CALayer设置UIView的边框的宽度、颜色、圆角半径、阴影等属性。也可以利用CALayer对控件实现3D的变化（翻转等）。此外自己创建的CALayer对象具有隐式动画，而UIView不具有隐式动画；
 3、CAAnimation（核心动画）可以实现基本的动画。
 
 CAAnimation是所有动画对象的父类，负责控制动画的持续时间和速度，是个抽象类，不能直接使用，应该使用它具体的子类：CAMediaTiming、CAAnimationGroup、CAPropertyAnimation(其所包含两个子类CABasicAnimation和CAKeyframeAnimation)、CATransition。
 */
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //平移动画
    [self translate];
    
    //缩放动画
//    [self zoom];
    
    //翻转动画
//    [self reversal];
    
    //旋转动画
//    [self rotation];
}

#pragma mark ————— 平移动画 —————
- (void)translate
{
    /**
     1、创建动画：
     */
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    /**
     2、设置动画：
     */
    
    //"keyPath"属性决定执行什么动画（平移、旋转等）
    animation.keyPath = @"position";
    
    //设置从哪个点开始执行动画
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    
    //设置到哪个点结束动画
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];  //从"fromValue"点移动到"toValue"点。
//    animation.byValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];  //从当前的位置移动到"byValue"的位置，设置"byValue"属性的时候就不要设置"fromValue"属性了。
    
    //设置单次动画的持续时间
    animation.duration = 2.0;
    
    //设置动画的执行次数（无限循环可以设置"HUGE_VALF"或者"MAXFLOAT"）
//    animation.repeatCount = HUGE_VALF;
    
    //设置整个动画的持续时间（整个动画的持续时间为6秒，一次动画的持续时间为2秒，所以这个动画会被执行3次）
    animation.repeatDuration = 6.0;
    
    //动画执行完毕后，视图一般都会恢复到动画执行之前的状态，如果想要保持动画执行之后的状态就要撰写下面的两句代码，缺一不可。
    animation.removedOnCompletion = NO;  //默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想要让图层保持显示动画执行后的状态，那就设置为NO。
    animation.fillMode = kCAFillModeForwards;  //设置动画执行完毕后保持最新的状态
    
    //设置动画延迟执行的时间（CACurrentMediaTime()为图层的当前时间）
    animation.beginTime = CACurrentMediaTime() + 2;
    
    /**
     3、添加动画：
     */
    [self.redView.layer addAnimation:animation forKey:animation.keyPath];
}

#pragma mark ————— 缩放动画 —————
//心跳动画
- (void)zoom
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath = @"transform.scale";
    animation.toValue = [NSNumber numberWithFloat:0.5];  //设置缩放比例
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.imageView.layer addAnimation:animation forKey:animation.keyPath];
}

#pragma mark ————— 翻转动画 —————
- (void)reversal
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath = @"transform";
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 1, 1, 0)];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.redView.layer addAnimation:animation forKey:animation.keyPath];
}

#pragma mark ————— 旋转动画 —————
-(void)rotation
{
    CABasicAnimation *animation = [CABasicAnimation animation];

    animation.keyPath = @"transform.rotation";
    animation.toValue = [NSNumber numberWithFloat:M_PI_2];//到哪个角度动画结束
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;

    [self.redView.layer addAnimation:animation forKey:animation.keyPath];
}

@end

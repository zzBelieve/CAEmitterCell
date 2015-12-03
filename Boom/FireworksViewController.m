//
//  ViewController.m
//  Boom
//
//  Created by ZZBelieve on 15/9/2.
//  Copyright (c) 2015年 galaxy-link. All rights reserved.
//

#import "FireworksViewController.h"

@interface FireworksViewController ()

@end

@implementation FireworksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    // Cells spawn in the bottom, moving up
    CAEmitterLayer *fireworksEmitter = [CAEmitterLayer layer];
    CGRect viewBounds = self.view.layer.bounds;
    //发射位置
    fireworksEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0, viewBounds.size.height-200);
    //发射源大小
    fireworksEmitter.emitterSize	= CGSizeMake(viewBounds.size.width/2.0, 0.0);
    //发射模式(kCAEmitterLayerPoints,kCAEmitterLayerOutline,kCAEmitterLayerSurface,kCAEmitterLayerVolume)
    fireworksEmitter.emitterMode	= kCAEmitterLayerOutline;
    //发射源形状
    fireworksEmitter.emitterShape	= kCAEmitterLayerLine;
    //渲染模式(kCAEmitterLayerAdditive与kCAEmitterLayerUnordered相比较, 合并重叠的部分使看上去更亮)
    fireworksEmitter.renderMode		= kCAEmitterLayerAdditive;
    //初始化随机数产生的种子
    fireworksEmitter.seed = (arc4random()%100)+1;
    
    // Create the rocket
    CAEmitterCell* rocket = [CAEmitterCell emitterCell];
    
    //每秒产生的粒子数
    rocket.birthRate		= 2.0;
    
    //周围发射角度
    rocket.emissionRange	= 0.0 * M_PI;  // some variation in angle
    //速度
    rocket.velocity			= 380;
    //速度范围
    rocket.velocityRange	= 200;
    //粒子y方向的加速度分量
    rocket.yAcceleration	= 75;
    
    //生命周期，既在屏幕上的显示时间要多长
    rocket.lifetime			= 1.02;	// we cannot set the birthrate < 1.0 for the burst
//    rocket.lifetimeRange = 5;
    
    
    rocket.contents			= (id) [[UIImage imageNamed:@"DazRing"] CGImage];
    //粒子尺寸
    rocket.scale			= 0.2;
    //粒子颜色
    rocket.color			= [[UIColor redColor] CGColor];
    
    //粒子的颜色green,red,blue 能改变的范围
    rocket.greenRange		= 1.0;		// different colors
    rocket.redRange			= 1.0;
    rocket.blueRange		= 1.0;
    //子旋转角度范围
    rocket.spinRange		= M_PI;		// slow spin
    
    
    
    // the burst object cannot be seen, but will spawn the sparks
    // we change the color here, since the sparks inherit its value
    CAEmitterCell* burst = [CAEmitterCell emitterCell];
    
    burst.birthRate			= 1.0;		// at the end of travel
    burst.velocity			= 0;
    burst.scale				= 2.5;
    
//    粒子red,blue,green 在生命周期内的改变速度
    burst.redSpeed			=-1.5;		// shifting
    burst.blueSpeed			=+1.5;		// shifting
    burst.greenSpeed		=+1.0;		// shifting
    
    burst.lifetime			= 0.35;
    
    // and finally, the sparks
    CAEmitterCell* spark = [CAEmitterCell emitterCell];
    
    spark.birthRate			= 400;
    spark.velocity			= 120;
    spark.emissionRange		= 2* M_PI;	// 360 deg
    spark.yAcceleration		= 75;		// gravity
    spark.lifetime			= 2;
    
    spark.contents			= (id) [[UIImage imageNamed:@"桃心"] CGImage];
    //缩放比例速度
    spark.scaleSpeed		=-0.2;
    spark.greenSpeed		=-0.1;
    spark.redSpeed			= 0.4;
    spark.blueSpeed			=-0.1;
    spark.alphaSpeed		=-0.25;
    //子旋转角度
    spark.spin				= 2* M_PI;
    
    //子旋转角度范围
    spark.spinRange			= 2* M_PI;
    
    // putting it together
    fireworksEmitter.emitterCells	= [NSArray arrayWithObject:rocket];
    rocket.emitterCells				= [NSArray arrayWithObject:burst];
    burst.emitterCells				= [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:fireworksEmitter];
    
    
//    UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-300, self.view.frame.size.width, 200)];
//    imgaeView.image = [UIImage imageNamed:@"xini.jpeg"];
//    [self.view addSubview:imgaeView];

    UIImage *image = [UIImage imageNamed:@"xini1.jpeg"];
    
    //__bridge id
    self.view.layer.contents = (__bridge id)(image.CGImage);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

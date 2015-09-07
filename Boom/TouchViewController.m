//
//  TouchViewController.m
//  Boom
//
//  Created by ZZBelieve on 15/9/7.
//  Copyright (c) 2015年 galaxy-link. All rights reserved.
//

#import "TouchViewController.h"

@interface TouchViewController ()



@property(nonatomic,strong)CAEmitterLayer *ringLayer;
@end

@implementation TouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor blackColor];
    self.ringLayer = [CAEmitterLayer layer];
    
    self.ringLayer.emitterPosition = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    self.ringLayer.emitterSize = CGSizeMake(50, 0);
    self.ringLayer.emitterMode = kCAEmitterLayerOutline;
    self.ringLayer.emitterShape = kCAEmitterLayerCircle;
    self.ringLayer.renderMode = kCAEmitterLayerBackToFront;
    
    
    // cell
    
    CAEmitterCell *ringCell = [CAEmitterCell emitterCell];
    
    [ringCell setName:@"ring"];
    
    
    ringCell.birthRate			= 0;
    ringCell.velocity			= 250;
    ringCell.scale				= 0.5;
    ringCell.scaleSpeed			=-0.2;
    ringCell.greenSpeed			=-0.2;	// shifting to green
    ringCell.redSpeed			=-0.5;
    ringCell.blueSpeed			=-0.5;
    ringCell.lifetime			= 2;
    
    ringCell.color = [[UIColor colorWithRed:0.9908 green:0.1719 blue:0.1866 alpha:1.0] CGColor];
    ringCell.contents = (id) [[UIImage imageNamed:@"桃心"] CGImage];
    
    
    self.ringLayer.emitterCells = [NSArray arrayWithObject:ringCell];
    
    [self.view.layer addSublayer:self.ringLayer];
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    [self touchAtPosition:touchPoint];
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    [self touchAtPosition:touchPoint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchAtPosition:(CGPoint)position
{
    // Bling bling..
    CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.ring.birthRate"];
    burst.fromValue			= [NSNumber numberWithFloat: 125.0];	// short but intense burst
    burst.toValue			= [NSNumber numberWithFloat: 0.0];		// each birth creates 20 aditional cells!
    burst.duration			= 0.5;
    burst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.ringLayer addAnimation:burst forKey:@"burst"];
    
    // Move to touch point
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    self.ringLayer.emitterPosition	= position;
    [CATransaction commit];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

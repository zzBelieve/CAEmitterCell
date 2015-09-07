//
//  FireViewController.m
//  Boom
//
//  Created by ZZBelieve on 15/9/6.
//  Copyright (c) 2015年 galaxy-link. All rights reserved.
//

#import "FireViewController.h"

@interface FireViewController ()



@property(nonatomic,strong)CAEmitterLayer *fireLayer;

@property(nonatomic,strong)CAEmitterLayer *smokeLayer;

@end

@implementation FireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.fireLayer = [CAEmitterLayer layer];
    
    self.smokeLayer = [CAEmitterLayer layer];
    
    
    
    self.fireLayer.emitterPosition = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height-60);
    self.fireLayer.emitterSize = CGSizeMake(self.view.frame.size.width, 0);
    self.fireLayer.emitterMode = kCAEmitterLayerOutline;
    self.fireLayer.renderMode = kCAEmitterLayerAdditive;
    
    
    self.smokeLayer.emitterPosition = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height-60);
    self.smokeLayer.emitterMode	= kCAEmitterLayerPoints;
    
    
    /**
     *  cell
     *
     *  @return <#return value description#>
     */
    
    
    CAEmitterCell *fireCell = [CAEmitterCell emitterCell];
    
    [fireCell setName:@"fire"];
    
    
    fireCell.birthRate			= 1000;
    fireCell.emissionLongitude  = M_PI_2;
    fireCell.velocity			= -80;
    fireCell.velocityRange		= 30;
    fireCell.emissionRange		= 1.1;
    fireCell.yAcceleration		= -200;
    fireCell.scaleSpeed			= 0.3;
    fireCell.lifetime			= 50;
    fireCell.lifetimeRange		= (50.0 * 0.35);
    
    fireCell.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fireCell.contents = (id) [[UIImage imageNamed:@"DazFire"] CGImage];
    
    
    CAEmitterCell* smoke = [CAEmitterCell emitterCell];
    [smoke setName:@"smoke"];
    
    smoke.birthRate			= 11;
    smoke.emissionLongitude = -M_PI / 2;
    smoke.lifetime			= 10;
    smoke.velocity			= -40;
    smoke.velocityRange		= 20;
    smoke.emissionRange		= M_PI / 4;
    smoke.spin				= 1;
    smoke.spinRange			= 6;
    smoke.yAcceleration		= -160;
    smoke.contents			= (id) [[UIImage imageNamed:@"DazSmoke"] CGImage];
    smoke.scale				= 0.1;
    smoke.alphaSpeed		= -0.12;
    smoke.scaleSpeed		= 0.7;
    
    
    self.smokeLayer.emitterCells	= [NSArray arrayWithObject:smoke];
    self.fireLayer.emitterCells	= [NSArray arrayWithObject:fireCell];
    [self.view.layer addSublayer:self.smokeLayer];
    [self.view.layer addSublayer:self.fireLayer];
    
    [self setFireAmount:0.9];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self controlFireHeight:event];
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self controlFireHeight:event];
}

- (void) controlFireHeight:(UIEvent *)event
{
    UITouch *touch			= [[event allTouches] anyObject];
    CGPoint touchPoint		= [touch locationInView:self.view];
    float distanceToBottom	= self.view.bounds.size.height - touchPoint.y;
    float percentage		= distanceToBottom / self.view.bounds.size.height;
    percentage				= MAX(MIN(percentage, 1.0), 0.1);
    
    NSLog(@"~~~%f",percentage);
    
    
    [self setFireAmount:2 *percentage];
}
- (void) setFireAmount:(float)zeroToOne
{
    // Update the fire properties
    [self.fireLayer setValue:[NSNumber numberWithInt:(zeroToOne * 500)]
                    forKeyPath:@"emitterCells.fire.birthRate"];
    [self.fireLayer setValue:[NSNumber numberWithFloat:zeroToOne]
                    forKeyPath:@"emitterCells.fire.lifetime"];
    [self.fireLayer setValue:[NSNumber numberWithFloat:(zeroToOne * 0.35)]
                    forKeyPath:@"emitterCells.fire.lifetimeRange"];
    self.fireLayer.emitterSize = CGSizeMake(50 * zeroToOne, 0);
    
    [self.smokeLayer setValue:[NSNumber numberWithInt:zeroToOne * 4]
                     forKeyPath:@"emitterCells.smoke.lifetime"];
    [self.smokeLayer setValue:(id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:zeroToOne * 0.3] CGColor]
                     forKeyPath:@"emitterCells.smoke.color"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

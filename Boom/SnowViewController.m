//
//  SnowViewController.m
//  Boom
//
//  Created by ZZBelieve on 15/9/2.
//  Copyright (c) 2015年 galaxy-link. All rights reserved.
//

#import "SnowViewController.h"

@interface SnowViewController ()
{

    CAEmitterLayer *snowlayer;
    
    int i;
    int iii;
 }
@end

@implementation SnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.bounds];
    img.image = [UIImage imageNamed:@"雪背景.jpeg"];
    [self.view addSubview:img];
    
    //粒子Layer
    
    snowlayer = [CAEmitterLayer layer];
    
    snowlayer.emitterPosition = CGPointMake(self.view.bounds.size.width, -30);
    snowlayer.emitterSize = CGSizeMake(self.view.bounds.size.width * 2.0, 0.0);
    
    snowlayer.emitterMode = kCAEmitterLayerOutline;
    snowlayer.emitterShape = kCAEmitterLayerLine;
    
    
    //cell
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    [snowCell setName:@"snow"];
    snowCell.birthRate =1;
    snowCell.lifetime = 120.0;
    snowCell.scale = 1.0;
    
    snowCell.velocity = -10;
    snowCell.velocityRange = 100;
    
    
    snowCell.yAcceleration = 2;
    snowCell.emissionRange = 0.5 * M_PI;		// some variation in angle
    snowCell.spinRange		= 0.5 * M_PI;		// slow spin
    
    snowCell.contents		= (id) [[UIImage imageNamed:@"DazFlake"] CGImage];
    snowCell.color			= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    // Make the flakes seem inset in the background
    snowlayer.shadowOpacity = 1.0;
    snowlayer.shadowRadius  = 0.0;
    snowlayer.shadowOffset  = CGSizeMake(0.0, 1.0);
    snowlayer.shadowColor   = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    snowlayer.emitterCells = [NSArray arrayWithObject:snowCell];
    [self.view.layer addSublayer:snowlayer];
    
  
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    button.frame = CGRectMake(10, self.view.frame.size.height-100, 80, 80);
//    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    
    NSArray *titleArray = @[@"增大雪量",@"减少雪量",@"加快速度",@"放慢速度"];
    
    CGFloat buttonW = 80;
    CGFloat buttonH = 35;
    CGFloat margin = 10;
    for (int p = 0; p<titleArray.count; p++) {
    
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(margin+p%titleArray.count*(margin+buttonW), self.view.frame.size.height-100, buttonW, buttonH)];
        
        [button setTitle:titleArray[p] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setBackgroundColor:[UIColor orangeColor]];
        button.tag = 100+p;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
    }
    
    
}
- (void)buttonClick:(UIButton *)button{

    switch (button.tag-100) {
        case 0:
        {
        
            i +=1;
            NSLog(@"%d",i);
            [snowlayer setValue:[NSNumber numberWithInt:i]
                          forKeyPath:@"emitterCells.snow.birthRate"];
        
        
        }
            break;
            
        case 1:
        {
        
            if (i<2){
            
                return;
            }
            
            i -=1;
            NSLog(@"%d",i);
            [snowlayer setValue:[NSNumber numberWithInt:i]
                     forKeyPath:@"emitterCells.snow.birthRate"];
        
        }
            break;
        case 2:
        {
        
        
            iii +=200;
            NSLog(@"%d",iii);
            [snowlayer setValue:[NSNumber numberWithInt:iii]
                     forKeyPath:@"emitterCells.snow.velocityRange"];
            
        
        }
            break;
            
        case 3:
        {
        
            if (iii<400){
                
                return;
            }
            
            iii -=200;
            NSLog(@"%d",iii);
            [snowlayer setValue:[NSNumber numberWithInt:iii]
                     forKeyPath:@"emitterCells.snow.velocityRange"];
        
        
        
        }
            break;
        default:
            break;
    }



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

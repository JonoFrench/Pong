//
//  ViewController.m
//  Pong
//
//  Created by Jonathan French on 02/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import "ViewController.h"
#import "PongViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.batSizeSlider setContinuous:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickPlayButton:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    PongViewController *p = [sb instantiateViewControllerWithIdentifier:@"PongViewController"];
    
    p.soundOn = self.soundSwitch.on;
    p.batSize = self.batSizeSlider.value;
    p.initialBallSpeed = self.speedSlider.value;
    [self.navigationController pushViewController:p animated:YES];
    
}

- (IBAction)switchSound:(id)sender {

    [self.lblSound setText:[NSString stringWithFormat:@"Sound %@",self.soundSwitch.on ==YES ? @"On":@"Off"]]
    ;
}

- (IBAction)speedSlide:(id)sender {
    [self.lblSpeed setText:[NSString stringWithFormat:@"Speed %d",(int)self.speedSlider.value]];
}

- (IBAction)batSlide:(id)sender {
    NSUInteger index = (NSUInteger)(self.batSizeSlider.value);
    NSString *size;

    if (index < 100) {
        index = 80;
    }
    else if (index >=100 && index < 120)
    {
        index=100;
    }
    else if (index >=120)
    {
        index = 120;
    }
    
    if(index == 80)
    {
        size=@"Small Bat";
    }
    else if (index==100)
    {
        size=@"Medium Bat";
    }
    else
    {
        size=@"Large Bat";
    }
    [self.batSizeSlider setValue:index animated:NO];
    [self.lblBat setText:[NSString stringWithFormat:@"%@",size]];

}
-(void)batSizeChanged:(UISlider *)sender
{
    NSUInteger index = (NSUInteger)(self.batSizeSlider.value);
    if (index < 100) {
        index = 80;
    }
    else if (index >=100 && index < 120)
    {
        index=100;
    }
    else if (index >=120)
    {
        index = 120;
    }
    [self.batSizeSlider setValue:index animated:NO];
}


@end

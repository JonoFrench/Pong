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
    [self  presentViewController:p animated:YES completion:nil];
}

- (IBAction)switchSound:(id)sender {
}

- (IBAction)speedSlide:(id)sender {
}

- (IBAction)batSlide:(id)sender {
}
@end

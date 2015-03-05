//
//  ViewController.h
//  Pong
//
//  Created by Jonathan French on 02/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISlider *batSizeSlider;
- (IBAction)clickPlayButton:(id)sender;
- (IBAction)switchSound:(id)sender;
- (IBAction)speedSlide:(id)sender;
- (IBAction)batSlide:(id)sender;

@end


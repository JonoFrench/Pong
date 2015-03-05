//
//  PongViewController.h
//  Pong
//
//  Created by Jonathan French on 02/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface PongViewController : UIViewController<UIGestureRecognizerDelegate>


@property (nonatomic,strong) UIView* ball;
@property (nonatomic,strong) UIView* rightBat;
@property (nonatomic,strong) UIView* leftBat;
@property (nonatomic,strong) NSTimer *moveTimer;
@property (nonatomic,strong) AVAudioPlayer *beep;
@property (nonatomic,strong) AVAudioPlayer *boop;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *pongPress;
@property (weak, nonatomic) IBOutlet UIView *rightDown;
@property (weak, nonatomic) IBOutlet UIView *rightUp;
@property (weak, nonatomic) IBOutlet UIView *leftUp;
@property (weak, nonatomic) IBOutlet UIView *leftDown;
@property (weak, nonatomic) IBOutlet UILabel *lblRightScore;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftScore;

@property int batSize;
@property int initialBallSpeed;
@property bool soundOn;

@property (strong, nonatomic) UILongPressGestureRecognizer *pressRightDown;
@property (strong, nonatomic) UILongPressGestureRecognizer *pressRightUp;
@property (strong, nonatomic) UILongPressGestureRecognizer *pressLeftDown;
@property (strong, nonatomic) UILongPressGestureRecognizer *pressLeftUp;

@end

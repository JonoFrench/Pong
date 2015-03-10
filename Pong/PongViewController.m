//
//  PongViewController.m
//  Pong
//
//  Created by Jonathan French on 02/03/2015.
//  Copyright (c) 2015 Jonathan French. All rights reserved.
//

#import "PongViewController.h"


@interface PongViewController ()


@end

#pragma mark Instance variables

int xPos;
int yPos;
int xSpeed;
int ySpeed;

int rightMove;
int leftMove;

int rightScore;
int leftScore;

int batHeight;
int batSpeed;
int ballSize;
int ballSpeed;

@implementation PongViewController


#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
    xPos = self.view.frame.size.height /2;
    yPos = self.view.frame.size.width /2;

    ballSpeed = self.initialBallSpeed;
    xSpeed = ballSpeed;
    ySpeed = ballSpeed;
    rightMove = 0;
    leftMove = 0;
    rightScore = 0;
    leftScore = 0;
    batHeight = self.batSize;
    batSpeed = 5;
    ballSize = 10;
    
    //set up the ball
    self.ball = [[UIView alloc]initWithFrame:CGRectMake(xPos, yPos, ballSize, ballSize)];
    [self.ball setUserInteractionEnabled:NO];
    [self.ball setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.ball];
    
    
    //set up the right bat (bottom)
    self.rightBat = [[UIView alloc]initWithFrame:CGRectMake( (self.view.frame.size.width/2)-(batHeight/2),self.view.frame.size.height-(30), batHeight, 10)];
    [self.rightBat setUserInteractionEnabled:NO];
    [self.rightBat setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.rightBat];

    //set up the left bat (top)
    self.leftBat = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-(batHeight/2),20, batHeight,10)];
    [self.leftBat setUserInteractionEnabled:NO];
    [self.leftBat setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.leftBat];
    
    //timer for the animation
    self.moveTimer = [NSTimer scheduledTimerWithTimeInterval:0.020 target:self selector:@selector(moveBall) userInfo:nil repeats:YES];
    
    //load the sounds
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"Pong_beep"
                                         ofType:@"wav"]];
    NSError *error = nil;
    self.beep = [[AVAudioPlayer alloc]
                                   initWithContentsOfURL:url
                                   error:&error];
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"Pong_boop"
                                         ofType:@"wav"]];
    self.boop = [[AVAudioPlayer alloc]
                 initWithContentsOfURL:url
                 error:&error];
// Set up Gesture recogisers to move bats
    self.pressRightDown
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(pressRightDown:)];
    [self.pressRightDown setDelegate:self];
    [self.pressRightDown setMinimumPressDuration:0];
    [self.pressRightDown setAllowableMovement:0];
    [self.rightDown addGestureRecognizer:self.pressRightDown];
    
    self.pressRightUp
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(pressRightUp:)];
    [self.pressRightUp setDelegate:self];
    [self.pressRightUp setMinimumPressDuration:0];
    [self.pressRightUp setAllowableMovement:0];
    [self.rightUp addGestureRecognizer:self.pressRightUp];

    self.pressLeftDown
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(pressLeftDown:)];
    [self.pressLeftDown setDelegate:self];
    [self.pressLeftDown setMinimumPressDuration:0];
    [self.pressLeftDown setAllowableMovement:0];
    [self.leftDown addGestureRecognizer:self.pressLeftDown];
    
    self.pressLeftUp
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(pressLeftUp:)];
    [self.pressLeftUp setDelegate:self];
    [self.pressLeftUp setMinimumPressDuration:0];
    [self.pressLeftUp setAllowableMovement:0];
    [self.leftUp addGestureRecognizer:self.pressLeftUp];
    
    [self.lblLeftScore setTransform:CGAffineTransformMakeRotation(M_PI)];
    
    if (self.soundOn)
    {
        [self.beep play];
    }

    [self.lblRightScore setText:[NSString stringWithFormat:@"%02d",rightScore]];
    [self.lblLeftScore setText:[NSString stringWithFormat:@"%02d",leftScore]];
    [self.moveTimer fire];
    
}

#pragma mark movement and controls

-(void)moveBall
{
    CGRect ballRect  = self.ball.frame;
    ballRect.origin.x = ballRect.origin.x + xSpeed;
    ballRect.origin.y = ballRect.origin.y + ySpeed;
    
    //check for hitting right bat
    if(ySpeed ==ballSpeed)
    {
        if (ballRect.origin.x > (self.rightBat.frame.origin.x-ballSize) && ballRect.origin.x <= (self.rightBat.frame.origin.x+batHeight-ballSize) && ballRect.origin.y >= (self.rightBat.frame.origin.y))
        {
            ballRect.origin.y = self.rightBat.frame.origin.y-ballSize;
            ballSpeed++;
            ySpeed = -ballSpeed;
            xSpeed = [self ballDirection:ballRect.origin.x batPos:self.rightBat.frame.origin.x-ballSize];
            if(self.soundOn)
            {
                [self.beep play];
            }
        }
    }
    //check for hitting left bat
    else if(ySpeed ==-ballSpeed)
    {
        if (ballRect.origin.x > (self.leftBat.frame.origin.x-ballSize) && ballRect.origin.x <= (self.leftBat.frame.origin.x+batHeight-ballSize) && ballRect.origin.y <= (self.leftBat.frame.origin.y))
        {
             ballRect.origin.y = self.leftBat.frame.origin.y+ballSize;
            ballSpeed++;
            ySpeed = ballSpeed;
            xSpeed = [self ballDirection:ballRect.origin.x batPos:self.leftBat.frame.origin.x-ballSize];
            if(self.soundOn)
            {
                [self.beep play];
            }
        }
    }
    //check for hitting bottom wall
    if (ballRect.origin.y >= (self.view.frame.size.height - ballSize))
    {
        ballRect.origin.y = self.view.frame.size.height - ballSize;
        if (ballSpeed > _initialBallSpeed) {
            ballSpeed--;
        }
        ySpeed = -ballSpeed;
        if(self.soundOn)
        {
            [self.boop play];
        }
        leftScore++;
        [self.lblLeftScore setText:[NSString stringWithFormat:@"%02d",leftScore]];
        if (leftScore==21) {
            [self.moveTimer invalidate];
            [self.ball removeFromSuperview];
            [self gameOver];
        }
        
    }
    //check for hitting top wall
    else if (ballRect.origin.y <= self.view.frame.origin.y)
    {
        ballRect.origin.y = self.view.frame.origin.y;
        if (ballSpeed > _initialBallSpeed) {
            ballSpeed--;
        }
        ySpeed = ballSpeed;
        if(self.soundOn)
        {
            [self.boop play];
        }
        rightScore++;
        [self.lblRightScore setText:[NSString stringWithFormat:@"%02d",rightScore]];
        
        if (rightScore==21) {
            [self.moveTimer invalidate];
            [self.ball removeFromSuperview];
            [self gameOver];
        }
        
    }
    //check for hitting left wall
    else if (ballRect.origin.x >= (self.view.frame.size.width-ballSize))
    {
        ballRect.origin.x = self.view.frame.size.width- ballSize;
        xSpeed = -ballSpeed;
        if(self.soundOn)
        {
            [self.beep play];
        }
    }
    //check for hitting right wall
    else if (ballRect.origin.x <= self.view.frame.origin.x)
    {
        ballRect.origin.x = self.view.frame.origin.x;
        xSpeed = ballSpeed;
        if(self.soundOn)
        {
            [self.beep play];
        }
    }
    
    if(rightMove !=0)
    {
        CGRect batRect  = self.rightBat.frame;
        if(rightMove > 0)
        {
            if (batRect.origin.x >= self.view.frame.size.width-batHeight)
            {
                rightMove=0;
            }
        }

        if(rightMove < 0)
        {
            if (batRect.origin.x <= 0) {
                rightMove=0;
            }
        }

        batRect.origin.x = batRect.origin.x +rightMove;
        self.rightBat.frame = batRect;
        [self.rightBat setNeedsDisplay];
    }

    if(leftMove !=0)
    {
        CGRect batRect  = self.leftBat.frame;
        if(leftMove > 0)
        {
            if (batRect.origin.x >= self.view.frame.size.width-batHeight)
            {
                leftMove=0;
            }
        }
        
        if(leftMove < 0)
        {
            if (batRect.origin.x <= 0)
            {
                leftMove=0;
            }
        }
        
        batRect.origin.x = batRect.origin.x +leftMove;
        self.leftBat.frame = batRect;
        [self.leftBat setNeedsDisplay];
    }
    
    self.ball.frame = ballRect;
}

//decide which y direction the ball is going to go in.
-(int)ballDirection:(int)ballpos batPos:(int)batpos
{
    int dir;
    int bat = ballpos-batpos;
    if (bat < batHeight/3)
    {
        dir= -ballSpeed;
    }
    else if ((bat > batHeight/3) && bat<= (batHeight/3*2))
    {
        dir=0;
    }
    else
    {
        dir= ballSpeed;
    }
    
    return dir;
}


-(void)pressRightDown:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if(UIGestureRecognizerStateBegan ==gestureRecognizer.state)
    {
        rightMove = batSpeed;
    }
    if(UIGestureRecognizerStateEnded ==gestureRecognizer.state)
    {
        rightMove = 0;
    }
}

-(void)pressRightUp:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if(UIGestureRecognizerStateBegan ==gestureRecognizer.state)
    {
        rightMove = -batSpeed;
    }
    if(UIGestureRecognizerStateEnded ==gestureRecognizer.state)
    {

        rightMove = 0;
    }
}

-(void)pressLeftDown:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if(UIGestureRecognizerStateBegan ==gestureRecognizer.state)
    {
        leftMove = batSpeed;
    }
    if(UIGestureRecognizerStateEnded ==gestureRecognizer.state)
    {
        leftMove = 0;
    }
}

-(void)pressLeftUp:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if(UIGestureRecognizerStateBegan ==gestureRecognizer.state)
    {
        leftMove = -batSpeed;
    }
    if(UIGestureRecognizerStateEnded ==gestureRecognizer.state)
    {
        
        leftMove = 0;
    }
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark end game

-(void)gameOver
{
    NSString *res;
    if (rightScore == 21) {
        res=@"Player 1 Won!";
    }
    else
    {
        res = @"Player 2 Won!";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                    message:res
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        [self returnToMenu];
    }
}

-(void)returnToMenu
{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

//
//  TimerViewController.h
//  CuociTempo
//
//  Created by Michele Navolio on 11/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tempo.h"


/*@class InfoViewController;
@protocol TimerDelegate <NSObject>

@required
-(BOOL)timerIsRunning:(BOOL)running;

@end*/
@interface TimerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *lancetta;
@property (strong, nonatomic) NSTimer *theTimer;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeToBack;

@property (assign,nonatomic)int peso;
@property (assign,nonatomic)NSString* cottura;

@property (nonatomic, strong) Tempo *tempo;
@property (assign,nonatomic)BOOL isRunning;
//@property (nonatomic, assign) id <TimerDelegate>delegate;

@end



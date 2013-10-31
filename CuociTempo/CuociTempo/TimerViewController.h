//
//  TimerViewController.h
//  CuociTempo
//
//  Created by Michele Navolio on 11/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *lancetta;
@property (strong, nonatomic) NSTimer *theTimer;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeToBack;
@property (assign,nonatomic)int peso;
@property (assign,nonatomic)NSString* cottura;


@end

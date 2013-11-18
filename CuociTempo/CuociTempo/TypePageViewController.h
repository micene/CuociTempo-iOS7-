//
//  TypePageViewController.h
//  CuociTempo
//
//  Created by Michele Navolio on 14/11/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypePageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *pressioneImage;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *pressioneTapGesture;

@property (weak, nonatomic) IBOutlet UIButton *listaButton;
@property (weak, nonatomic) IBOutlet UIButton *preferitiButton;

@property (assign, nonatomic) NSInteger index;

@property (retain,nonatomic)NSString *animationForKey;
@property (retain,nonatomic)NSMutableArray *images;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeTimer;

@end

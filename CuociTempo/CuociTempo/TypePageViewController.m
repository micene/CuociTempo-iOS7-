//
//  TypePageViewController.m
//  CuociTempo
//
//  Created by Michele Navolio on 14/11/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import "TypePageViewController.h"
#import "ViewController.h"
#import "ListaTableViewController.h"


@implementation TypePageViewController

    NSMutableArray *imagesArr;
    int currentImage;
    BOOL stopRequested;
    NSTimeInterval duration;
    NSArray *imageNames;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.pressioneTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToPressionePie:)];
    [self.pressioneImage addGestureRecognizer:self.pressioneTapGesture];
    
    if ([self.title isEqualToString:@"Pressione"]) {
        
        imageNames = @[@"win_1.png", @"win_2.png", @"win_3.png"];

    }else if ([self.title isEqualToString:@"Normale"]) {
        
        imageNames = @[@"Pressione1.png", @"win_15.png", @"win_16.png"];

    }if ([self.title isEqualToString:@"Microonde"]) {
        
        imageNames = @[@"Pressione1.png", @"win_8.png", @"win_12.png"];
        
    }
    
    self.images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [self.images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    self.pressioneImage.image = [self.images objectAtIndex:0];
    
    self.swipeTimer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeToTimer:)];
    [self.swipeTimer setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:self.swipeTimer];
    

}

-(void) setupTheAnimation {
    
    self.pressioneImage.userInteractionEnabled = NO;
    
    stopRequested = NO;
    currentImage = 0;
    duration = 1/self.images.count+1;
    NSLog(@"%f",duration);
    [self stepThroughImages];
    
    [self performSelector:@selector(stopTheAnimation) withObject:nil afterDelay:4.0];
}

- (void) stepThroughImages{
    
    self.pressioneImage.image = [self.images objectAtIndex: currentImage];
    
    if (currentImage == self.images.count-1) {
        currentImage = 0;
    } else {
        currentImage++;

    }
     if (stopRequested && duration < 0.1f) {
         
        // we're slowing down gradually
        duration *= 1.1f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self stepThroughImages];
        });
    } else if (!stopRequested) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self stepThroughImages];
        });
    }
}

-(void) stopTheAnimation {
    
    NSLog(@"stop");
     
    stopRequested = YES;
    currentImage = 0;
    
    ViewController *typeWheel = [self.storyboard instantiateViewControllerWithIdentifier:@"TypeWheel"];
    typeWheel.title = self.title;
    CATransition* transition = [CATransition animation];
    transition.duration = 1;
    transition.type = kCATransitionFade;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:typeWheel animated:NO];
    
}

-(void)tapToPressionePie:(UITapGestureRecognizer*)sender{
    
    if (sender.state == UIGestureRecognizerStateRecognized) {

        [self setupTheAnimation];

    }    
}

- (IBAction)listaPushed:(id)sender {

    ListaTableViewController *lista = [[UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Lista"];
    lista.title = self.title;
    
    [self.navigationController pushViewController:lista animated:YES];
    
}

- (IBAction)preferitiPushed:(id)sender {
    NSLog(@"preferiti");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
    
}

-(void)swipeToTimer:(UISwipeGestureRecognizer*)sender{
    
        NSLog(@"swipe controller not found");
}

@end
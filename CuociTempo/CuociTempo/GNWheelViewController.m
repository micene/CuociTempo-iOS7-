//
//  GNViewController.m
//  WheelComponent
//
//  Copyright (c) 2012 Ahmed Ragab
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "GNWheelViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ListaTableViewController.h"

@interface GNWheelViewController ()

@end

@implementation GNWheelViewController


- (GNWheelView *)wheelView{
    
    return (GNWheelView *)self.view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    
    self.wheelView.delegate = self;
    
    //inizializzo la imageview
    UIImageView *cuoci = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.wheelView addSubview:cuoci];
    
    [self.wheelView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0]];
    cuoci.alpha = 1;
    cuoci.image = [UIImage imageNamed:[NSString stringWithFormat:@"cuocitempo.jpg"]];
    
    //inizio dell animazione che porta alla scomparsa della image view
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2.5];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    cuoci.alpha = 0.0;
    [self.wheelView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
  //  [self.wheelView reloadData];
    [UIView commitAnimations];
    
    self.wheelView.idleDuration = 0;
}

- (void)animationDidStop:(NSString *)animationID
                finished:(NSNumber *)finished
                 context:(void *)context {

    //se l animazione dell imageview e' finita allora mostro la ruota
    if([animationID isEqualToString:@"fadeIn"]){
        
        [self.wheelView reloadData];
        
    }
}

-(void)goToListaFrom:(GNWheelView *)wheelView{
    
    ListaTableViewController *lista = [[UIStoryboard storyboardWithName:@"SecondStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"Lista"];
    
    [self.navigationController pushViewController:lista animated:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (unsigned int)numberOfRowsOfWheelView:(GNWheelView *)wheelView{
    
    return 12;
}

- (UIView *)wheelView:(GNWheelView *)wheelView viewForRowAtIndex:(unsigned int)index{

    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item.jpg"]];
}

- (float)rowWidthInWheelView:(GNWheelView *)wheelView{
    
    return 300;
    
}

- (float)rowHeightInWheelView:(GNWheelView *)wheelView{
    
    return 83;
    
}

- (void)wheelView:(GNWheelView *)wheelView didSelectedRowAtIndex:(unsigned int)index{
    
    NSLog(@"index %i",index);
    
   
}

- (BOOL)wheelView:(GNWheelView *)wheelView shouldEnterIdleStateForRowAtIndex:(unsigned int)index animated:(BOOL *)animated{
    
    return NO;
}

- (UIView *)wheelView:(GNWheelView *)wheelView idleStateViewForRowAtIndex:(unsigned int)index{
    
    return nil;
}

- (void)wheelView:(GNWheelView *)wheelView didStartIdleStateForRowAtIndex:(unsigned int)index{
    
    
}

@end

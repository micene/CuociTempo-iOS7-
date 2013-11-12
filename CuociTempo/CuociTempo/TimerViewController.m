//
//  TimerViewController.m
//  CuociTempo
//
//  Created by Michele Navolio on 11/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import "TimerViewController.h"
#import "DataManager.h"

@interface TimerViewController ()
{
    //creiamo un bool che serve per sapere se il conto alla rovescia sta andando
    BOOL isRunning;
    
    //Creiamo un variabile intera che useremo come contatore
    int countdown;
    
    NSString *ris;
    
}
@end

@implementation TimerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSLog(@"peso %i",self.peso);
    NSLog(@"cottura %@",self.cottura);
    
    if([self.cottura isEqualToString:@"Microonde"]){
        ris = [[DataManager sharedClass]tempoPerAlimento:[NSString stringWithFormat:@"cottura.type == 'Microonde' AND alimento.name == '%@' AND peso.pesoid = %i",self.title,(self.peso + 1)]];
    }else{
        ris = [[DataManager sharedClass]tempoPerAlimento:[NSString stringWithFormat:@"cottura.type == '%@' AND alimento.name == '%@'",self.cottura,self.title]];
    }
    
    //Mettiamo isRunning su no perché il timer è fermo
    isRunning = NO;
    
    //diamo un valore iniziale alla primitiva
    countdown = ris.doubleValue* 60;
	// Do any additional setup after loading the view.
    
    
    self.countdownLabel.text = [self formattazioneLabel];
    
    NSLog(@"name:%@ tempo:%@",self.title,ris);
    
    self.swipeToBack = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [self.swipeToBack setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:self.swipeToBack];

}

- (IBAction)start:(id)sender {
    
    //controllo se sta gia andando e se si impedisco l'esecuzione del resto del codice
    if (isRunning) return;
    
    
    //Impostiamo su si il booleano isRunning
    isRunning = YES;
    
    
    //Invochiamo il primo tick
    [self spin];
    
    //Avviamo la data con il metodo scheduledTimerWithTimeInterval che ogni secondo invoca il metodo tick
    self.theTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}


- (IBAction)stop:(id)sender {
    
    //Controlliamo se il timer è fermo, nel caso impediamo l'esecuzione del resto del codice
    if (!isRunning) return;
    
    
    //Impostiamo no il boolenao isRunning
    isRunning = NO;
    countdown = ris.doubleValue*60;

    
    [self.lancetta.layer removeAllAnimations];
    //Controlliamo se il timer è valido (cioè sta andando) e nel caso lo fermiamo
    //Se cercassimo di invalidare un timer fermo andrebbe in crash l'App
    if ( [self.theTimer isValid] ) [self.theTimer invalidate];
    
    //Assegnamo alla proprietà text della UILabel la stringa restituita dal metodo formattazioneLabel
    self.countdownLabel.text = [self formattazioneLabel];

}

- (NSString*)formattazioneLabel {
    
    //creo 3 numeri interi con la matematica necessaria per calcolare secondi, minuti e ore
	int hours = (countdown / 3600);
	int minutes = ((countdown / 60) - hours * 60);
	int seconds = (countdown - ((minutes * 60) + hours * 3600));
    
    //Rappresentiamo il tempo formattando una stringa in questo modo
	NSString* rap = [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];
    
    //restituiamo il valore della stringa rap
    return rap;
}

-(void)tick{
    //sottraiamo uno dal countdown
    countdown--;
    
    //controlliamo che il valore di countdown sia minore di zero
    if (countdown < 0) {
        
        //se è minore di zero allora il timer è finito
        
        //Impostiamo no il boolenao isRunning
        isRunning = NO;
        
        //Controlliamo se il timer è valido (cioè sta andando) e nel caso lo fermiamo
        if ( [self.theTimer isValid] ) [self.theTimer invalidate];
        
        //Azzeriamo il tempo nella label
        self.countdownLabel.text = @"00:00:00";
        
        //Arrstiamo il codice
        return;
    }
    
    //Assegnamo alla proprietà text della UILabel la stringa restituita dal metodo formattazioneLabel
	self.countdownLabel.text = [self formattazioneLabel];


}

- (void)spin {
    
    //creiamo una' anomazione di tipo CABasicAnimation usando il metodo animationWithKeyPath
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    //Impostiamo la durata ad 1 secondo
    rotationAnimation.duration = countdown;
    
    //Impostiamo il valore iniziale usando un NSNumber
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    
    //Impostiamo il valore finale usando un NSNumber e un calcolo matematico per convertire i gradi della rotazione
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    
    //Impostiamo la valueFunction grazie al metodo functionWithName della classe CAValueFunction
    //serve per dirgli che vogliamo una rotazione (espressa dalla costante kCAValueFunctionRotateZ)
    rotationAnimation.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    
    //Impostiamo l'andamento del tempo su lineare
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //Aggiungiamo l'animazione al layer della lancetta per farla ruotare
    [self.lancetta.layer addAnimation:rotationAnimation forKey:nil];
    

}

-(void)back:(UISwipeGestureRecognizer*)sender{
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController popViewControllerAnimated:NO];
    
}
@end

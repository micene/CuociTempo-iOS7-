//
//  DataManager.h
//  CuociTempo
//
//  Created by Michele Navolio on 20/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Alimento,Cottura;

@interface DataManager : NSObject<NSFetchedResultsControllerDelegate>

@property (nonatomic,retain)NSFetchedResultsController *fetchedResultsController;


+(DataManager*)sharedClass;
-(void)setup;


-(NSManagedObjectContext*)managedObjectContext;

//-----------------------------------------

//METODI FETCHRESULTCONTROLLER

-(NSFetchedResultsController *)fetchedResultsController;
-(NSFetchedResultsController *)fetchedEntityWithClassName:(NSString *)className
                                  sortDescriptorWithKey:(NSString *)sortDescriptors
                                     sectionNameKeyPath:(NSString *)sectionNameKeypath
                                             setPredicate:(NSPredicate *)predicate;

-(NSInteger)numeroDiSezioni;
-(NSInteger)numeroDiRighePerSezione:(NSInteger)sezione;
-(NSString*)nomePerSezione:(NSInteger)sezione;
-(NSManagedObject*)configuraPerCella:(NSIndexPath*)cella;

//-------------------

//METODI FETCHREQUEST

-(NSArray*)fetchaRequest:(NSString*)className predicate:(NSString*)predicateString;

-(NSManagedObject*)managedObjectFromFetch:(NSArray*)fetchedObject cell:(unsigned int)cell;

-(NSInteger)numerodiEntitaFromFetch:(NSArray*)fetchedObject sezione:(NSInteger)sezione;

-(NSString*)tempoPerAlimento:(NSString*)predicateString;

@end

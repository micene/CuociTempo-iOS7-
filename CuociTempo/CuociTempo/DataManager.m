//
//  DataManager.m
//  CuociTempo
//
//  Created by Michele Navolio on 20/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"
#import "Alimento.h"
#import "Tipo.h"
#import "Cottura.h"
#import "Tempo.h"


@implementation DataManager

@synthesize fetchedResultsController = _fetchedResultsController;

static DataManager* sharedClassInstance = nil;

+(DataManager *)sharedClass{
    
    @synchronized(self){
        if (!sharedClassInstance) {
            sharedClassInstance = [[DataManager alloc]init];
        }
    }
    return sharedClassInstance;
}

-(void)setup{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Alimento"];
    fetchRequest.predicate =[ NSPredicate predicateWithFormat:@"ANY cotturas.type == %@",[NSString stringWithFormat:@"Pressione"]];
   // fetchRequest.predicate =[ NSPredicate predicateWithFormat:@"cottura.type== %@",[NSString stringWithFormat:@"microonde"]];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
  /*for (Cottura *cottura in fetchedObjects) {
       // NSLog(@"Name: %@",cottura.cotturaType);
        NSLog(@"Alimenti :%@",[cottura.alimentoCottura valueForKey:@"name"]);
    }*/
    NSLog(@"entro %i",fetchedObjects.count);
   for (Alimento *tempo in fetchedObjects) {
        NSLog(@"name:%@",tempo.name);
       //NSLog(@"cottura %@",[alimento.cotturaAlimento valueForKey:@"cotturaType"]);
    }
    
    
}


-(NSString*)tempoPerAlimento:(NSPredicate*)predicate{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tempo"];
    //    fetchRequest.predicate =[ NSPredicate predicateWithFormat:@"ANY cotturas.type == %@",[NSString stringWithFormat:@"Pressione"]];
    fetchRequest.predicate = predicate;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];

    NSLog(@"count %i",fetchedObjects.count);
    NSLog(@"Tempo %@",[fetchedObjects lastObject]);
    for (Tempo *tempo in fetchedObjects) {
        NSLog(@"Tempo :%@",tempo.time);
     }
    Tempo *tempo = [fetchedObjects lastObject];
    return tempo.time;
}



-(NSInteger)numerodiEntita:(NSInteger)sezione predicate:(NSPredicate *)predicate{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Alimento"];
//    fetchRequest.predicate =[ NSPredicate predicateWithFormat:@"ANY cotturas.type == %@",[NSString stringWithFormat:@"Pressione"]];
    fetchRequest.predicate = predicate;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    return fetchedObjects.count;
}

-(NSManagedObject*)fetchRequestPerCella:(unsigned int)cell predicate:(NSPredicate *)predicate{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Alimento"];
  //  fetchRequest.predicate =[ NSPredicate predicateWithFormat:@"ANY cotturas.type == %@",[NSString stringWithFormat:@"Pressione"]];
    fetchRequest.predicate = predicate;

    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
    return [fetchedObjects objectAtIndex:cell];
}


-(NSFetchedResultsController *)fetchedEntityWithClassName:(NSString *)className sortDescriptorWithKey:(NSString *)sortDescriptors sectionNameKeyPath:(NSString *)sectionNameKeypath setPredicate:(NSPredicate *)predicate{
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    
    NSFetchRequest *fethcRequest = [NSFetchRequest fetchRequestWithEntityName:className];
    
    fethcRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:sortDescriptors ascending:YES]];

    fethcRequest.predicate = predicate;
    
    NSFetchedResultsController *aFetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fethcRequest managedObjectContext:[self managedObjectContext]  sectionNameKeyPath:nil cacheName:@"Root"];
    
    _fetchedResultsController.delegate = self;
        
    _fetchedResultsController = aFetchResultsController;
    
    return _fetchedResultsController;
}

-(NSFetchedResultsController *)fetchedResultsController{
    
    // NSLog(@"%@",_fetchedResultsController);
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    
    NSFetchRequest *fethcRequest = [NSFetchRequest fetchRequestWithEntityName:@"Alimento"];
    
    fethcRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"tipo.nametype" ascending:YES]];
    
    fethcRequest.predicate = [NSPredicate predicateWithFormat:@"ANY  self.cotturas.type == %@",[NSString stringWithFormat:@"microonde"]];
    
    [fethcRequest setFetchBatchSize:20];
    
    
    NSFetchedResultsController *aFetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fethcRequest managedObjectContext:[self managedObjectContext]  sectionNameKeyPath:@"tipo.nametype" cacheName:nil];
    
    
    _fetchedResultsController = aFetchResultsController;
    
    return _fetchedResultsController;
    
}

-(NSManagedObjectContext*)managedObjectContext{
    
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
}

-(NSInteger)numeroDiSezioni{
    
    NSInteger count = [[_fetchedResultsController sections]count];
    return count;
}

-(NSInteger)numeroDiRighePerSezione:(NSInteger)sezione{
    
    id sectionInfo = [[_fetchedResultsController sections]objectAtIndex:sezione];
    
    return [sectionInfo numberOfObjects];
}

-(NSString *)nomePerSezione:(NSInteger)sezione{
    
    id <NSFetchedResultsSectionInfo> theSection = [[_fetchedResultsController sections]objectAtIndex:sezione];
    
    return [theSection name];
    
}

-(NSManagedObject*)configuraPerCella:(NSIndexPath*)cella{

    return [_fetchedResultsController objectAtIndexPath:cella];
    
}

@end

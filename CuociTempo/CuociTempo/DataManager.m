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
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tipo"];
   // fetchRequest.predicate =[ NSPredicate predicateWithFormat:@"ANY cotturas.type == %@",[NSString stringWithFormat:@"Pressione"]];
   // fetchRequest.predicate =[ NSPredicate predicateWithFormat:@"cottura.type== %@",[NSString stringWithFormat:@"microonde"]];
//    fetchRequest.sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:@"nametype" ascending:NO];
  //  fetchRequest.predicate = [NSPredicate predicateWithFormat:@"tipoid == alimentos.tipo.tipoid AND alimentos.alimentoid == alimentos.cotturas.alimentos.alimentoid WHERE cotturas.type == %@",[NSString stringWithFormat:@"Pressione"]];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(0 != SUBQUERY(alimentos, $x, (0 != SUBQUERY($x.cotturas, $y, $y.type==%@).@count)).@count)",[NSString stringWithFormat:@"Pressione"]];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"nametype" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    
  /*for (Cottura *cottura in fetchedObjects) {
       // NSLog(@"Name: %@",cottura.cotturaType);
        NSLog(@"Alimenti :%@",[cottura.alimentoCottura valueForKey:@"name"]);
    }*/
    NSLog(@"entro %i",fetchedObjects.count);
    for (Tipo *tempo in fetchedObjects) {
        NSLog(@"tipo name  %@",tempo.nametype);

    }
}

//METODI FETCHREQUST

-(NSArray*)fetchaRequest:(NSString*)className predicate:(NSString*)predicateString{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:className];

    fetchRequest.predicate = [NSPredicate predicateWithFormat:predicateString];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
 
    return fetchedObjects;
}

-(NSManagedObject*)managedObjectFromFetch:(NSArray*)fetchedObject cell:(unsigned int)cell{
    
    return [fetchedObject objectAtIndex:cell];
    
}

-(NSInteger)numerodiEntitaFromFetch:(NSArray*)fetchedObject sezione:(NSInteger)sezione{
    
    return fetchedObject.count;
}

-(NSString*)tempoPerAlimento:(NSString*)predicateString{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tempo"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:predicateString];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];

    NSLog(@"count %i",fetchedObjects.count);
    NSLog(@"Tempo %@",[fetchedObjects lastObject]);
    for (Tempo *tempo in fetchedObjects) {
        NSLog(@"Tempo :%@",tempo.time);
     }
    Tempo *tempo = [fetchedObjects lastObject];
    
    return tempo.time;
}

//METODI FETCHEDRESULTCONTROLLER

-(NSFetchedResultsController *)fetchedEntityWithClassName:(NSString *)className sortDescriptorWithKey:(NSString *)sortDescriptors sectionNameKeyPath:(NSString *)sectionNameKeypath setPredicate:(NSPredicate *)predicate{
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    
    NSFetchRequest *fethcRequest = [NSFetchRequest fetchRequestWithEntityName:className];
    
    fethcRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:sortDescriptors ascending:YES]];

    fethcRequest.predicate = predicate;
    
    NSFetchedResultsController *aFetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fethcRequest managedObjectContext:[self managedObjectContext]  sectionNameKeyPath:sectionNameKeypath cacheName:@"Root"];
    
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

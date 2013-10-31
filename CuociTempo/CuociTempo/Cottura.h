//
//  Cottura.h
//  CuociTempo
//
//  Created by Michele Navolio on 31/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Alimento, Tempo;

@interface Cottura : NSManagedObject

@property (nonatomic, retain) NSNumber * cotturaid;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *tempos;
@property (nonatomic, retain) NSSet *alimentos;
@end

@interface Cottura (CoreDataGeneratedAccessors)

- (void)addTemposObject:(Tempo *)value;
- (void)removeTemposObject:(Tempo *)value;
- (void)addTempos:(NSSet *)values;
- (void)removeTempos:(NSSet *)values;

- (void)addAlimentosObject:(Alimento *)value;
- (void)removeAlimentosObject:(Alimento *)value;
- (void)addAlimentos:(NSSet *)values;
- (void)removeAlimentos:(NSSet *)values;

@end

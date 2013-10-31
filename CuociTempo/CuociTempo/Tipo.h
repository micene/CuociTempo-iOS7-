//
//  Tipo.h
//  CuociTempo
//
//  Created by Michele Navolio on 31/10/13.
//  Copyright (c) 2013 Michele Navolio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Alimento;

@interface Tipo : NSManagedObject

@property (nonatomic, retain) NSString * nametype;
@property (nonatomic, retain) NSNumber * tipoid;
@property (nonatomic, retain) NSSet *alimentos;
@end

@interface Tipo (CoreDataGeneratedAccessors)

- (void)addAlimentosObject:(Alimento *)value;
- (void)removeAlimentosObject:(Alimento *)value;
- (void)addAlimentos:(NSSet *)values;
- (void)removeAlimentos:(NSSet *)values;

@end

//
//  NSDictionary+ObjectFiltering.h
//  MaxwellForestExercise
//
//  Created by Khang Nguyen on 20/09/2015.
//  Copyright (c) 2015 Khang Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ObjectFiltering)

- (id)objectWithClass:(Class)objectClass
               forKey:(NSString *)key;

- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key;
- (NSMutableArray *)mutableArrayValueForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key;

@end

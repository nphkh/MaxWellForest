//
//  NSDictionary+ObjectFiltering.m
//  MaxwellForestExercise
//
//  Created by Khang Nguyen on 20/09/2015.
//  Copyright (c) 2015 Khang Nguyen. All rights reserved.
//

#import "NSDictionary+ObjectFiltering.h"

@implementation NSDictionary (ObjectFiltering)

- (id)objectWithClass:(Class)objectClass
               forKey:(NSString *)key
{
    id object = [self objectForKey:key];
    
    return [object isKindOfClass:objectClass] ? object : nil;
}

- (NSDictionary *)dictionaryForKey:(NSString *)key
{
    return [self objectWithClass:[NSDictionary class]
                          forKey:key];
}

- (NSArray *)arrayForKey:(NSString *)key
{
    return [self objectWithClass:[NSArray class]
                          forKey:key];
}

- (NSMutableArray *)mutableArrayValueForKey:(NSString *)key
{
    return [self objectWithClass:[NSMutableArray class]
                          forKey:key];
}

- (NSString *)stringForKey:(NSString *)key
{
    return [self objectWithClass:[NSString class]
                          forKey:key];
}

- (NSNumber *)numberForKey:(NSString *)key
{
    return [self objectWithClass:[NSNumber class]
                          forKey:key];
}

- (NSDate *)dateForKey:(NSString *)key
{
    return [self objectWithClass:[NSDate class]
                          forKey:key];
}


@end

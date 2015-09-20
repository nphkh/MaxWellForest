//
//  APIServices.m
//  MaxwellForestExercise
//
//  Created by Khang Nguyen on 20/09/2015.
//  Copyright (c) 2015 Khang Nguyen. All rights reserved.
//

#import "APIServices.h"

#import "NSDictionary+ObjectFiltering.h"

#import "CoffeeShop.h"

#import <CoreLocation/CoreLocation.h>

const NSString *CLIENT_SECRET = @"YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL";
const NSString *CLIENT_ID = @"ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G";

@interface APIServices()

@property(nonatomic, strong) NSURLSession *session;

@end

@implementation APIServices

- (instancetype)init
{
    if(self = [super init])
    {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    
    return self;
}

- (void)loadCoffeeListWithCurrentLocation:(CLLocation *)currentLocation
                          completionBlock:(void(^)(NSArray *, NSError *))completionBlock
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=20130815&ll=%f,%f&query=coffee",
                                       CLIENT_ID,
                                       CLIENT_SECRET,
                                       currentLocation.coordinate.latitude,
                                       currentLocation.coordinate.longitude]];
    
    [[self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if(!error)
        {
            NSError *parsingError = nil;
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:&parsingError];
            
            if(!parsingError)
            {
                NSMutableArray *list = [[NSMutableArray alloc] init];
                NSDictionary *responseDict = [dictionary dictionaryForKey:@"response"];
                NSArray *coffeeShopDicts = [responseDict arrayForKey:@"venues"];
                
                for(NSDictionary *coffeeShopDict in coffeeShopDicts)
                {
                    NSString *name = [coffeeShopDict stringForKey:@"name"];
                    
                    NSDictionary *contactDict = [coffeeShopDict dictionaryForKey:@"contact"];
                    NSNumber *phoneNumber = [contactDict numberForKey:@"phone"];
                    
                    NSDictionary *locationDict = [coffeeShopDict dictionaryForKey:@"location"];
                    NSString *address = [locationDict stringForKey:@"address"];
                    NSNumber *lat = [locationDict numberForKey:@"lat"];
                    NSNumber *lng = [locationDict numberForKey:@"lng"];
                    
                    CoffeeShop *shop = [[CoffeeShop alloc] initWithName:name
                                                                address:address
                                                            phoneNumber:phoneNumber
                                                               location:[[CLLocation alloc] initWithLatitude:lat.longValue
                                                                                                   longitude:lng.longValue]];

                    [list addObject:shop];
                }
                
                NSArray *sortedList;
                sortedList = [list sortedArrayUsingComparator:^NSComparisonResult(CoffeeShop *shopA, CoffeeShop *shopB)
                {
                    CLLocationDistance distanceA = [currentLocation distanceFromLocation:shopA.location];
                    CLLocationDistance distanceB = [currentLocation distanceFromLocation:shopB.location];
                    
                    return distanceA > distanceB;
                }];                
                
                completionBlock(sortedList, nil);
            }
            else
            {
                completionBlock(nil, parsingError);
            }
        }
        else
        {
            completionBlock(nil, error);
        }
    }] resume];
}

@end

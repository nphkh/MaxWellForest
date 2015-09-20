//
//  CoffeeViewController.m
//  MaxwellForestExercise
//
//  Created by Khang Nguyen on 20/09/2015.
//  Copyright (c) 2015 Khang Nguyen. All rights reserved.
//

#import "CoffeeViewController.h"

#import "APIServices.h"

#import <CoreLocation/CoreLocation.h>

#import "TableViewCell.h"

#import "CoffeeShop.h"

@interface CoffeeViewController() <CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) APIServices *apiServices;
@property(nonatomic, assign) NSInteger counter;
@property(nonatomic, strong) NSArray *shopList;
@property(nonatomic, strong) CLLocation *location;

@end

@implementation CoffeeViewController

- (void)loadView
{
    [super loadView];
    
    self.title = @"Coffee";
    self.counter = 5;
    
    self.apiServices = [[APIServices alloc] init];
    self.shopList = [[NSArray alloc] init];
    
    [self setupLocationManager];
}

- (void)setupLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)requestCoffeeListWithLocation:(CLLocation *)location
{
    __weak __typeof(self) weakSelf = self;
    
    [self.apiServices loadCoffeeListWithCurrentLocation:location
                                        completionBlock:^(NSArray *coffeeShopList, NSError *error)
     {
         __strong __typeof(weakSelf) strongSelf = weakSelf;
         
         if(!error)
         {
             strongSelf.shopList = coffeeShopList;
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [strongSelf.tableView reloadData];                 
             });
         }
         else
         {
             NSLog(@"SHOW ERROR - Error Handler for iOS 7 + iOS 8. Dont have enough time to implement this");
         }
     }];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    
    CoffeeShop *shop = [self.shopList objectAtIndex:indexPath.row];
    
    CLLocationDistance distance = [shop.location distanceFromLocation:self.location];
    
    [cell configureCellWithShop:shop
                       distance:distance];    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopList.count;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //Avoid calling API every second.
    if(self.counter++ >= 5)
    {
        self.location = locations.lastObject;
        
        [self requestCoffeeListWithLocation:self.location];
        
        self.counter = 0;
    }
}

@end

//
//  SpinHeaderViewController.h
//  That's Rad
//
//  Created by Jarrek Holmes on 4/8/15.
//  Copyright (c) 2015 Jarrek Holmes. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface SpinHeaderViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *Main;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *rsg;


@end

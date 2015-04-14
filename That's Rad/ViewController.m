
//  ViewController.m
//  That's Rad
//
//  Created by Jarrek Holmes on 2/23/15.
//  Copyright (c) 2015 Jarrek Holmes. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end
@implementation ViewController
int s = 0;
int myGoal;
int mHeading;
int mySpin;
int counter;
int counter2;
int spinHeading;
int spin2Heading;
bool upGo;
bool downGo;
int previous;
int k = 1;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingHeading];
    [self.locationManager startUpdatingLocation];
    NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(aTime) userInfo:nil repeats:YES];

    // Do any additional setup after loading the view, typically from a nib.
}
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {

    if(s==0){
        myGoal = arc4random_uniform(360);
        s=1;
        mySpin = 0;
        spinHeading = newHeading.trueHeading;
        spin2Heading = newHeading.trueHeading;
        counter = 0;
        counter2 = 0;
        upGo = true;
        downGo = true;
        previous = mHeading;
    }
    
    mHeading = newHeading.trueHeading;
    if(mHeading <100 && previous > 260){
        downGo = false;
        upGo = true;
        spinHeading = 0;
    }
    if(mHeading> 260 && previous< 100){
        upGo = false;
        downGo = true;
        spin2Heading = 360;
    }
    
    
    if(mHeading > spinHeading && upGo){
        if(mHeading - spinHeading<100){
            counter += mHeading - spinHeading;
        spinHeading = mHeading;
        if(counter >= 360){
            counter = counter-360;
            mySpin++;
        }
        }
    }

    else if(mHeading < spin2Heading && downGo){
        if(spin2Heading - mHeading < 100){counter2 += spin2Heading-mHeading;
        spin2Heading = mHeading;
        if(counter2 >= 360){
            counter2 = counter2-360;
            mySpin++;
        }
        }
    }
    
    
    
    self.goalLabel.text = [NSString stringWithFormat: @"%s %i", "Try to get to", myGoal];
    self.trueHeading.text = [NSString stringWithFormat:@"%i", mHeading];
    if(mHeading <= myGoal + 1 && mHeading >= myGoal - 1){
        self.correctLabel.text = [NSString stringWithFormat: @"%s", "WOOH"];
        self.trueHeading.text = [NSString stringWithFormat:@"%i", myGoal];

        [self performSelector:@selector(myMethod) withObject:nil afterDelay:1.0];
     }
    else{
       self.correctLabel.text = [NSString stringWithFormat: @"%s", "NOPE"];
        }
    self.countSpin.text = [NSString stringWithFormat: @"%s %i %s", "You are at", counter, "Spins"];
    previous = mHeading;
}
-(void)aTime
{
    
    if(k<60){
    self.timer.text = [NSString stringWithFormat:@"%d",k];
    }
    else if (k%60 < 10){
        self.timer.text = [NSString stringWithFormat: @" %d %s %d %d", k/60, ":", 0, k%60];
    }
    else {
        self.timer.text = [NSString stringWithFormat: @" %d %s %d",  k/60, ":", k%60];
    }
    
    k++;
    
}
- (void)myMethod{
    if(mHeading <=myGoal + 1 && mHeading >=myGoal){
        myGoal = arc4random_uniform(360);
        
        self.goalLabel.text = [NSString stringWithFormat: @"%s %i", "Try to get to", myGoal];
        self.correctLabel.text = [NSString stringWithFormat: @"%s", "NOPE"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

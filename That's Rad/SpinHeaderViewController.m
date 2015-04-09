//
//  SpinHeaderViewController.m
//  That's Rad
//
//  Created by Jarrek Holmes on 4/8/15.
//  Copyright (c) 2015 Jarrek Holmes. All rights reserved.
//

#import "SpinHeaderViewController.h"

@interface SpinHeaderViewController ()

@end

@implementation SpinHeaderViewController
int x = 0;
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
int i = 1;
double f = .1;
double j=.01;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
     self.locationManager.delegate = self;
     [self.locationManager startUpdatingHeading];
     [self.locationManager startUpdatingLocation];
     NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(aTime) userInfo:nil repeats:YES];
    NSTimer *bTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(bTime) userInfo:nil repeats:YES];
     NSTimer *cTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(cTime) userInfo:nil repeats:YES];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if(x==0){
        x=1;
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
    if(mHeading <10 && previous > 350){
        downGo = false;
        upGo = true;
        spinHeading = 0;
    }
    if(mHeading> 350 && previous< 10){
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
    
    
    
}

-(void)aTime
{
    i++;
}
-(void)bTime
{
    f = f+.1;
}
-(void)cTime{
    if(i <2){
        self.rsg.text = [NSString stringWithFormat:@"%s", "Ready!"];
    }
    else if (i <4){
        self.rsg.text = [NSString stringWithFormat:@"%s", "Set!"];
    }
    else if (i < 6){
        self.rsg.text = [NSString stringWithFormat:@"%s", "Go!"];
    }
    else if(i<64){
        self.Main.text = [NSString stringWithFormat:@"%d", mySpin];
        self.rsg.text = [NSString stringWithFormat:@"%d %s",60 - i + 4, ":" ];
    }
    else{
        self.rsg.text = [NSString stringWithFormat:@"%s %d %s", "You got", mySpin, "spins"];
    }
    j = j+.01;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

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
int x = -1;
int myGoal;
int mHeading = 0;
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
int mySpin2;

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void) viewDidAppear:(BOOL)animated{
    j = 0;
    i = 0;
    f = 0;
    x = -1;
    mySpin = 0;
    mySpin2 = 0;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingHeading];
    [self.locationManager startUpdatingLocation];

}

-(void)chooseDirection{
    if(previous >300 && mHeading < 60){
        upGo = true;
        downGo = false;
        x = 1;
        NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(aTime) userInfo:nil repeats:YES];
        NSTimer *bTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(bTime) userInfo:nil repeats:YES];
        NSTimer *cTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(cTime) userInfo:nil repeats:YES];
        self.Main.text = [NSString stringWithFormat:@"%s", "Great!"];
        counter = 0;
        counter2 = 0;
    }
    else if (previous < 60 && mHeading > 300){
        downGo = true;
        upGo = false;
        x = 1;
        NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(aTime) userInfo:nil repeats:YES];
        NSTimer *bTimer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(bTime) userInfo:nil repeats:YES];
        NSTimer *cTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(cTime) userInfo:nil repeats:YES];
        self.Main.text = [NSString stringWithFormat:@"%s", "GREAT"];
        counter = 0;
        counter2 = 0;
    }
    else{
        self.Main.text = [NSString stringWithFormat:@"%s", "Spin slowly in your desired direction of travel"];
        previous = mHeading;
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if ( x == -1){
        previous = newHeading.trueHeading;
        x= 0;
    }
    if(x==0){
        mHeading = newHeading.trueHeading;
        [self performSelector:@selector(chooseDirection) withObject:nil afterDelay:0.0];
        mySpin = 0;
        spinHeading = newHeading.trueHeading;
        spin2Heading = newHeading.trueHeading;
        counter = 0;
        counter2 = 0;
    }
    else if (i>6){
    mHeading = newHeading.trueHeading;
        if(upGo){
            if(mHeading > previous){
                counter += mHeading - previous;
            }
            else if(mHeading < previous){
                int test = mHeading;
                test += 360 - previous;
                
                if(test < 300){
                    counter += test;
                }
                else{
                    

                }
            }
            if (counter >= 360){
                mySpin++;
                counter = counter - 360;
            }
        }
        if(downGo){
            if(mHeading < previous){
                counter += previous - mHeading;
            }
            else if(mHeading > previous){
                int test = previous;
                test += 360 - mHeading;
                if(test< 300){
                    counter += test;
                }
                else{
                    

                }
            }
            if (counter >= 360){
                mySpin++;
                counter = counter - 360;
            }
        }
        previous = mHeading;
    }
    else{
         previous = mHeading;
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
        mySpin2 = mySpin;
        self.Main.text = [NSString stringWithFormat:@"%d", mySpin];
        self.rsg.text = [NSString stringWithFormat:@"%.2f",60 - j+ 5 ];
    }
    else{
        self.rsg.text = [NSString stringWithFormat:@"%s %d %s", "You got", mySpin2, "spins"];
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

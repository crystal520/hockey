//
//  IntroLayer.m
//  hokey5
//
//  Created by Fedor on 9/13/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "IntroLayer.h"

@implementation IntroLayer

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    IntroLayer *layer = [IntroLayer node];
    
    [scene addChild: layer];
    
    return scene;
}

-(void) onEnter
{
    [super onEnter];
    
    [self scheduleOnce  :@selector(makeTransition:)
                 delay  :0.0];
    
    globalOptions *tmp = [globalOptions sharedInstance];
    
    CGSize temp1 = CGSizeMake(0.0,0.0);
    CGFloat temp2 = 1.0;
    
    BOOL HD = ![[CCDirector sharedDirector] enableRetinaDisplay:YES];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        temp1 = [[CCDirector sharedDirector] winSizeInPixels];
        
        if (HD)
        {
            NSLog(@"Running on IPhone without HD");
            [tmp setIphoneTexture];
            temp2 = 1.0;
        }
        else
        {
            NSLog(@"Running on IPhone with HD");
            [tmp setIphoneTextureHD];
            temp2 = 2.0;
        }
        
        NSLog(@"CCDirector.winsizeinpixels x=%3.2f,y=%3.2f",temp1.width,temp1.height);
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        
        temp1 = [[CCDirector sharedDirector] winSize];
        if (HD)
        {
            NSLog(@"Running on IPad without HD");
            [tmp setIpadTexture];
            temp1 = [[CCDirector sharedDirector] winSize];
            temp2 = 1.0;
        }
        else
        {
            NSLog(@"Running on IPad with HD");
            [tmp setIpadTextureHD];
            temp1 = [[CCDirector sharedDirector] winSize];
            temp2 = 2.0;
        }

        NSLog(@"CCDirector.winsizeinpixels x=%3.2f,y=%3.2f",temp1.width,temp1.height);
    }
    
    [tmp loadScore];
    [tmp setPlayer1		:0];
    [tmp setPlayer2		:0];
    [tmp setTimer		:INFINITY];
    [tmp setFriction            :0.0414];
    [tmp setRadius		:1.0];
    [tmp setScaleX		:temp2];
    [tmp setScaleY		:temp2];
    [tmp setScale               :temp2];
    [tmp setScreen		:temp1];
    
    float width=[[UIScreen mainScreen] bounds].size.width;
    float height=[[UIScreen mainScreen] bounds].size.height;
    
    NSLog(@"UIScreen x=%3.2f,y=%3.2f",width,height);

}

-(void) makeTransition:(ccTime)dt
{
    [[CCDirector sharedDirector] 
     replaceScene:[HelloWorldLayer node]];
}
@end

//
//  menuOpt.m
//  hokey5
//
//  Created by Fedor on 9/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "menuOpt.h"


@implementation menuOpt

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	menuOpt *layer = [menuOpt node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) 
    {
        self.isTouchEnabled = YES;

        my_glob = [globalOptions sharedInstance];
        
        CGSize screen_size = [my_glob getScreen];
        
        
        CGPoint sliderpos = ccp(screen_size.width/2.0+50.0,
                                (screen_size.height/2.0)-10.0);
                                                        
                                                                
                                                                                
        m_sliderFric = [[UISlider alloc] init];
        [m_sliderFric addTarget			:self 
                                action          :@selector(sliderFricAction:)
                            forControlEvents    :UIControlEventValueChanged];
        
        
        
        m_sliderFric.backgroundColor = [UIColor clearColor]; 
        m_sliderFric.minimumValue = 0.0;
        m_sliderFric.maximumValue = 0.10;
        CGPoint temp = [self convertToNodeSpace:sliderpos];
        
        [m_sliderFric setFrame:CGRectMake(temp.x,
                                          temp.y,
                                          170.0,
                                          20.0)];
                                                                                                                                        
        [[[CCDirector sharedDirector] view] addSubview:m_sliderFric];
                                                                                                        
        [m_sliderFric setValue:[my_glob getFriction] animated:YES];
        
        

        
        m_sliderTime = [[UISlider alloc] init];
        
        [m_sliderTime addTarget     :self 
                            action  :@selector(sliderTimeAction:) 
                forControlEvents    :UIControlEventValueChanged];
        
        m_sliderTime.backgroundColor = [UIColor clearColor]; 
        m_sliderTime.minimumValue = 30.0;
        m_sliderTime.maximumValue = 3600.0;
        
        temp = [self convertToNodeSpace:ccp(sliderpos.x,
                                            sliderpos.y - 50.0)];
                                                                                        
        [m_sliderTime setFrame:CGRectMake(temp.x,
                                        temp.y,
                                        170.0 ,
                                        20.0 )];
                                                                        
        [[[CCDirector sharedDirector]  view] addSubview:m_sliderTime];
                                                
        [m_sliderTime setValue:[my_glob getTimer] animated:YES];
        
        
        m_sliderRadius = [[UISlider alloc] init];
        
        [m_sliderRadius addTarget               :self 
                        action                  :@selector(sliderRadiusAction:) 
                        forControlEvents	:UIControlEventValueChanged];
        
        m_sliderRadius.backgroundColor = [UIColor clearColor]; 
        m_sliderRadius.minimumValue = 1.0;
        m_sliderRadius.maximumValue = 3.0;
        
        temp = [self convertToNodeSpace:ccp(sliderpos.x,
                                            sliderpos.y - 100.0)];
                                                                                        
        [m_sliderRadius setFrame:CGRectMake(temp.x,
                                            temp.y,
                                            170.0 ,
                                            20.0 )];
                                                                        
        [[[CCDirector sharedDirector] view]  addSubview:m_sliderRadius];
                                                
        [m_sliderRadius setValue:[my_glob getRadius]  animated:YES];
        
        
        
        
        
        
        m_fric_label = 
            [CCLabelTTF labelWithString:
                    [NSString stringWithFormat	:@"Friction = %3.4f",
                                                    [my_glob getFriction]] 
                                    fontName	:@"Arial"
                                    fontSize	:24];
                                                        
        m_fric_label.position = ccp((screen_size.width/2.0) - 100,
                                    (screen_size.height/2.0));
                                                
                                                
        m_fric_label.color = ccc3(255, 255, 55);
        [self addChild:m_fric_label];
        
        m_time_label = 
            [CCLabelTTF labelWithString:
                    [NSString stringWithFormat	:@"Round Time = %1.0f sec",							[my_glob getTimer]]
                                    fontName	:@"Arial" 
                                    fontSize	:24];
        
        m_time_label.position = ccp(m_fric_label.position.x,
                                    m_fric_label.position.y + 50.0);
                                                        
        m_time_label.color = ccc3(255, 255, 55);
        [self addChild:m_time_label];
        
        
        
        m_radius_label = 
        [CCLabelTTF labelWithString:
                    [NSString stringWithFormat	:@"Radius = %3.4f",
                                                    [my_glob getRadius]]
                                    fontName	:@"Arial"
                                    fontSize	:24];
        
        m_radius_label.position =
                                ccp(m_time_label.position.x,
                                    m_time_label.position.y + 50.0);
                                                        
        m_radius_label.color = ccc3(255, 255, 55);
        [self addChild:m_radius_label];
        
        
        
        CCMenuItemLabel *backmenu =
                [CCMenuItemFont	itemWithString      :@"Back"
                                        target      :self 
                                        selector    :@selector(backMenu)];
        backmenu.color = ccc3(255, 255, 55);


        CCMenu *menu = [CCMenu menuWithItems:backmenu,nil];
        [menu alignItemsVertically];
        [menu setPosition:ccp((screen_size.width/2.0),
                              (screen_size.height/2.0) - 50.0)];
        [self addChild:menu];
        
        m_sprite = [[CCSprite alloc] initWithFile:[my_glob getTextureName:TEX_KLUSHKA1]];
        [m_sprite setPosition:ccp(2.0*m_sprite.contentSize.width,
                                  2.0*m_sprite.contentSize.height)];
        [m_sprite setScale:[my_glob getRadius]];
        [self addChild:m_sprite];
    }
    return self;
}



- (void) backMenu
{
    [m_sliderRadius removeFromSuperview];
    [m_sliderTime removeFromSuperview];
    [m_sliderFric removeFromSuperview];

    [[CCDirector sharedDirector] replaceScene:
        [CCTransitionFade transitionWithDuration    :1
                                            scene   :[HelloWorldLayer node]]];
}



- (void)sliderFricAction:(id)sender;
{
    [my_glob setFriction:[m_sliderFric value]];
    m_fric_label.string =
                    [NSString stringWithFormat:@"Friction = %3.4f",
                                                    [my_glob getFriction]];
}

- (void)sliderTimeAction:(id)sender;
{
    if ([m_sliderTime value] >= 3590.0) 
    {
            [my_glob setTimer:INFINITY];
    }
    else
    {
            [my_glob setTimer:[m_sliderTime value]];
    }
    
    
    
    m_time_label.string =
                        [NSString stringWithFormat:@"RoundTime = %1.0f sec",
                                                         [my_glob getTimer]];
}


- (void)sliderRadiusAction:(id)sender;
{
    [my_glob setRadius:[m_sliderRadius value]];
    m_radius_label.string =
                            [NSString stringWithFormat:@"Radius PL = %3.4f",
                                                        [my_glob getRadius]];
    [m_sprite setScale:[my_glob getRadius]];
    [m_sprite setPosition:ccp(m_sprite.contentSize.width * 2.0,
                              m_sprite.contentSize.height * 2.0)];
}


- (void) dealloc
{
    [m_sliderRadius dealloc];
    [m_sliderTime dealloc];
    [m_sliderFric dealloc];
    [super dealloc];
}


@end

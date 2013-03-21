//
//  HelloWorldLayer.m
//  hokey5
//
//  Created by Fedor on 9/13/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "HelloWorldLayer.h"

@implementation HelloWorldLayer

+(CCScene *) scene
{
    
    CCScene *scene			= [CCScene node];
    HelloWorldLayer *layer	= [HelloWorldLayer node];
    [scene addChild: layer];
    
    return scene;
}

-(id) init
{
    if( (self=[super init]) )
    {
        
        self.isTouchEnabled = YES;
        
        globalOptions *my_glob  = [globalOptions sharedInstance];
        [my_glob findMax];
        [my_glob findLast];
        
        CGSize screen_size  = [my_glob getScreen];
        
        
        CCMenuItemLabel *newgame    =
        [CCMenuItemFont
                     itemWithString	:@"New Game"
                            target	:self
                            selector    :@selector(startGame)];
        newgame.color = ccc3(255, 255, 55);
        
        
        CCMenuItemLabel *optmenu    =
        [CCMenuItemFont
                    itemWithString	:@"Options"
                            target	:self
                            selector    :@selector(optGame)];
        optmenu.color = ccc3(255, 255, 55);
        
        
        
        CCMenuItemLabel *hirecordmenu	=
        [CCMenuItemFont
                    itemWithString	:@"HI Score"
                            target	:self
                            selector    :@selector(hiGame)];
        hirecordmenu.color = ccc3(255, 255, 55);
        
        
        
        CCMenuItemLabel *exitgame   =
        [CCMenuItemFont
                     itemWithString	:@"Exit"
                            target	:self
                            selector    :@selector(exitGame)];
        exitgame.color = ccc3(255, 255, 55);
        
        
        
        CCMenu *menu =
        [CCMenu
         menuWithItems : newgame,
         optmenu,
         hirecordmenu,
         exitgame,
         nil];

        [menu alignItemsVerticallyWithPadding:50.0];
        [menu
         setPosition:
         ccp((screen_size.width/2.0),
             (screen_size.height/2.0))];
        
        [self addChild:menu];
        
        
        m_spritelabelmax =
                [[CCSprite alloc]
                        initWithFile:[my_glob getTextureName:TEX_LABEL_MAX]];
        
        [m_spritelabelmax
         setPosition:
         ccp(((screen_size.width/3.0)-70),
             ((screen_size.height/2.0)-70))];
        
        [self addChild:m_spritelabelmax];
        
        
        m_spritelabellast =
                [[CCSprite alloc]
                        initWithFile:[my_glob getTextureName:TEX_LABEL_LAST]];
        
        [m_spritelabellast
         setPosition:
         ccp(((2.0*screen_size.width/3.0)+70),
             ((screen_size.height/2.0)-70))];
        [self addChild:m_spritelabellast];
        
        
        CGSize label_max_size = CGSizeZero;
        
        label_max_size.width = [m_spritelabelmax contentSize].width*0.5;
        label_max_size.height = [m_spritelabelmax contentSize].height*0.8;
        
        m_labelmax =
        [CCLabelTTF
         labelWithString:[NSString stringWithFormat:@"MAX %@ points %d",
                                               [my_glob getMaxResultName],
                                               [my_glob getMaxResultInt]]
         
         fontName	:@"Marker Felt"
         fontSize	:([m_spritelabelmax contentSize].height/6.1)
         dimensions	:label_max_size
         hAlignment	:kCCTextAlignmentCenter];
        
        [m_labelmax setPosition:ccp(m_spritelabelmax.position.x,
                                     m_spritelabelmax.position.y - 15.0)];
        m_labelmax.color = ccc3(0,0,200);
        [self addChild:m_labelmax];
        
        
        CGSize label_last_size = CGSizeZero;

        label_last_size.width = [m_spritelabellast contentSize].width * 0.5;
        label_last_size.height = [m_spritelabellast contentSize].height * 0.8;
        
        m_labellast =
        
        [CCLabelTTF
         labelWithString:[NSString stringWithFormat:@"LAST %@ points %d",
                                              [my_glob getLastResultName],
                                              [my_glob getLastResultInt]]
         
         fontName       :@"Marker Felt"
         fontSize	:([m_spritelabellast contentSize].height/6.1)
         dimensions     :label_last_size
         hAlignment     :kCCTextAlignmentCenter];
        
        [m_labellast setPosition:ccp(m_spritelabellast.position.x,
                                     m_spritelabellast.position.y - 15.0)];
        m_labellast.color = ccc3(0,0,200);
        [self addChild:m_labellast];
        
        
        
    }
    return self;
}

- (void) startGame
{
    [[CCDirector sharedDirector]
     replaceScene:
     [CCTransitionFade transitionWithDuration	:1
                                        scene	:[menuPlCount node]]];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        exit(0);
    }
}

- (void) exitGame
{
    UIAlertView *temp =
    [[UIAlertView alloc] initWithTitle        :@"Exit"
                            message	      :@"Are you sure?"
                            delegate          :self
                            cancelButtonTitle :@"No" 
                            otherButtonTitles :@"Yes", nil];
    [temp show];
    [temp release];
}

- (void) optGame
{
    [[CCDirector sharedDirector] 
     replaceScene:[CCTransitionFade
                            transitionWithDuration	:1
                                            scene	:[menuOpt node]]];
}

- (void) hiGame
{
    [[CCDirector sharedDirector] 
     replaceScene:[CCTransitionFade
                            transitionWithDuration	:1
                                            scene	:[resultScene node]]];
}


- (void) dealloc
{
    [super dealloc];
}

@end

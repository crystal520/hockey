//
//  menuPlCount.m
//  hokey5
//
//  Created by Fedor on 9/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "menuPlCount.h"


@implementation menuPlCount

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	menuPlCount *layer = [menuPlCount node];
	
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
            
            
            
            CCMenuItemLabel *newgame1 =
                        [CCMenuItemFont
                            itemWithString   :@"1 Player"
                                    target   :self
                                selector     :@selector(startGame1PL)];
            newgame1.color = ccc3(255, 255, 55);
            
            
    
            
            CCMenuItemLabel *newgame2 =
                    [CCMenuItemFont
                        itemWithString	:@"2 Players"
                                target	:self 
                            selector    :@selector(startGame2PL)];
            newgame2.color = ccc3(255, 255, 55);
            
            
            
            CCMenuItemLabel *newgame1_box2d =
            [CCMenuItemFont
                         itemWithString	:@"1 Player (box2d version)"
                            target	:self
                            selector    :@selector(startGame1PL_box2d)];
            newgame1_box2d.color = ccc3(255, 255, 55);
            
            
            
            CCMenuItemLabel *newgame2_box2d =
            [CCMenuItemFont
                        itemWithString	:@"2 Players (box2d version)"
                             target	:self
                            selector    :@selector(startGame2PL_box2d)];
            newgame2_box2d.color = ccc3(255, 255, 55);
            
            
            
            CCMenuItemLabel *exitgame =
                    [CCMenuItemFont
                        itemWithString	:@"Back"
                            target      :self
                            selector    :@selector(backGame)];
            exitgame.color = ccc3(255, 255, 55);
            
            
            
            
            CCMenu *menu = [CCMenu menuWithItems:
                                            newgame1,
                                            newgame2,
                                            newgame1_box2d,
                                            newgame2_box2d,
                                            exitgame,
                                            nil];
            
            [menu alignItemsVerticallyWithPadding:50.0];
            
            [menu setPosition:ccp((screen_size.width/2.0),
                                (screen_size.height/2.0))];
            [self addChild:menu];
            
		
	}
	return self;
}

- (void) startGame1PL
{
    [my_glob setGameEngine:engine_my_phys];
    
    [[CCDirector sharedDirector] 
            replaceScene:[CCTransitionFade
                                    transitionWithDuration  :1
                                                    scene   :[GameAI node]]];
}

- (void) startGame1PL_box2d
{
    [my_glob setGameEngine:engine_box2d];
    
    [[CCDirector sharedDirector]
             replaceScene:[CCTransitionFade
                                   transitionWithDuration  :1
                                                   scene   :[GameAI node]]];
}


- (void) startGame2PL_box2d
{
    [my_glob setGameEngine:engine_box2d];
    
    [[CCDirector sharedDirector]
            replaceScene:[CCTransitionFade
                            transitionWithDuration  :1
                                            scene   :[GamePL node]]];
}





- (void) startGame2PL
{
    [my_glob setGameEngine:engine_my_phys];
    
    
	[[CCDirector sharedDirector]
            replaceScene:[CCTransitionFade
                                    transitionWithDuration  :1
                                                    scene   :[GamePL node]]];
}

- (void) backGame
{
	[[CCDirector sharedDirector] 
            replaceScene:[CCTransitionFade
                            transitionWithDuration  :1
                                            scene   :[HelloWorldLayer node]]];
}


- (void) dealloc
{
	[super dealloc];
}

@end

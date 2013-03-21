//
//  Game.m
//  hokey5
//
//  Created by Fedor on 9/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameAI.h"


@implementation GameAI

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameAI *layer = [GameAI node];
	
	[scene addChild: layer];
	
	return scene;
}


- (id) init
{
    if (self=[super init]) 
    {

        self.isTouchEnabled = YES;
        
        
        my_glob = [globalOptions sharedInstance];
        
        if ([my_glob getGameEngine] == engine_my_phys)
        {
            m_game_layer = [[GameLayer alloc] init];
        }
        if ([my_glob getGameEngine] == engine_box2d)
        {
            m_game_layer = [[GameLayer_box2d alloc] init];
        }
        
        [self addChild:m_game_layer];   
        
        [self schedule:@selector(updateAI:)];
        
        [[[CCDirector sharedDirector] 
                        touchDispatcher] addTargetedDelegate	:self 
                                                    priority	:0 
                                            swallowsTouches	:NO];
    }
    
    return self;
}

- (void) updateAI:(ccTime) dt;
{
    
    CGPoint aibot = [m_game_layer getPlayerPosition:PLAYER_2];
    CGPoint ball = [m_game_layer getObjectPosition];
            
    if (CGRectContainsPoint([m_game_layer getBorder:PLAYER_2_BORDER], ball))
    {
        if (((ball.y > aibot.y) || 
                        (ball.y < aibot.y)) && 
                (ball.x < aibot.x))
        {
            aibot.y = ball.y;
            aibot.x = ball.x + 150.0;
        }
        
        if ([m_game_layer getObjectSpeed] < 50.0)
        {
            aibot.x = ball.x;
            
            if (aibot.y > ball.y)
            {
                aibot.y = 0;
            }
            
            if (aibot.y < ball.y)
            {
                aibot.y = CGRectGetMaxY([m_game_layer getBorder:0]);
            }
        }	
    }
    [m_game_layer setPlayerUnderNum	:PLAYER_2
                                pos	:aibot];
}


- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	
    CGPoint  location = [self convertTouchToNodeSpace:touch];

    [m_game_layer   setPlayerUnderNum   :0
                                    pos :location];

    return YES;
}



- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint  location = [self convertTouchToNodeSpace:touch];

    [m_game_layer   setPlayerUnderNum   :0
                                    pos :location];
}


- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint  location = [self convertTouchToNodeSpace:touch];
    [m_game_layer   setPlayerUnderNum	:0
                                    pos	:location];
}


- (void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint  location = [self convertTouchToNodeSpace:touch];
    [m_game_layer   setPlayerUnderNum	:0
                                    pos	:location];
}


- (void) dealloc
{
	[super dealloc];
}

@end

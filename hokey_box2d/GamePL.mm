//
//  GamePL.m
//  hokey5
//
//  Created by Fedor on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePL.h"


@implementation GamePL

+(CCScene *) scene
{
    CCScene *scene	= [CCScene node];
    
    GamePL *layer	= [GamePL node];
    
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
            m_game_layer= [[GameLayer alloc] init];
        }
        if ([my_glob getGameEngine] == engine_box2d)
        {
            m_game_layer= [[GameLayer_box2d alloc] init];
        }
        
        [self addChild:m_game_layer];

        m_touch_hash[0]		= 0;
        m_touch_hash[1]		= 0;
        m_touch_active[0]	= FALSE;
        m_touch_active[1]	= FALSE;
    }
    
    return self;
}




- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  
	
    for (int i = 0; i < [touches count]; i++) 
    {
        UITouch *touch = [[touches allObjects] objectAtIndex:i];
                                                        
        CGPoint location = [self convertTouchToNodeSpace:touch];
        
        int val = [m_game_layer getPlayerNumUnderPoint:location];
        
        if (val > NO_BODY_AT_POINT)
        {
            if (m_touch_active[val] == FALSE) 
            {
                m_touch_active[val] = TRUE;
                m_touch_hash[val]	= [touch hash];
                
                [m_game_layer
                    setPlayerUnderNum	:val
                                    pos	:location];
            }
        }
            
    }
			
	
}

- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (int i = 0; i < [touches count]; i++) 
    {
        UITouch *touch = [[touches allObjects] objectAtIndex:i];
                                                        
        CGPoint location = [self convertTouchToNodeSpace:touch];

        int val = -1;
        
        if ((m_touch_active[0] == TRUE) && 
                (m_touch_hash[0] == [touch hash]))
        {
            val = 0;
        }
        
        if ((m_touch_active[1] == TRUE) && 
                (m_touch_hash[1] == [touch hash]))
        {
            val = 1;
        }


        if (val > NO_BODY_AT_POINT)
        {
            [m_game_layer
                setPlayerUnderNum       :val
                                pos	:location];
        }

    }
}

- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (int i = 0; i < [touches count]; i++) 
    {
        UITouch *touch = [[touches allObjects] objectAtIndex:i];
                        
        CGPoint location = [self convertTouchToNodeSpace:touch];
        
        int val = -1;

        if ((m_touch_active[0] == TRUE) && 
                (m_touch_hash[0] == [touch hash]))
        {
            val = 0;
        }
        
        if ((m_touch_active[1] == TRUE) && 
                (m_touch_hash[1] == [touch hash]))
        {
            val = 1;
        }


        if (val > NO_BODY_AT_POINT)
        {
            m_touch_active[val] = FALSE;
            m_touch_hash[val]	= 0;
            
            [m_game_layer
                setPlayerUnderNum	:val 
                                pos	:location];
        }
    }
	
	
}

- (void) dealloc
{
   // [m_game_layer dealloc];
    [super dealloc];
}

@end


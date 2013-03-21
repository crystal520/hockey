//
//  GameLayer.m
//  hokey5
//
//  Created by Fedor on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"


@implementation GameLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameLayer *layer = [GameLayer node];

	[scene addChild: layer];
	
	return scene;
}


- (id) init
{
	if (self=[super init]) 
	{
            m_paused = FALSE;

            my_glob = [globalOptions sharedInstance];
            
            [my_glob setPlayer1:0];
            [my_glob setPlayer2:0];		
            
            
            m_phys = [[MyPhys alloc] init];
            
            CGSize screen_size = [my_glob getScreen];	
            m_timer_count = 0.0;
            
            CCSprite *m_gamefield_sprite =
                            [CCSprite spriteWithFile:
                                        [my_glob getTextureName:TEX_GAMEFIELD]];
            
            [m_gamefield_sprite setPosition:ccp(screen_size.width/2.0,
                                                screen_size.height/2.0)];
                                                                                            
            [self addChild:m_gamefield_sprite z:-1];

            m_score_pl1 = [CCLabelTTF labelWithString   :@"0"
                                            fontName    :@"Marker Felt"
                                            fontSize    :20.0];
                                                                            
            m_score_pl1.position = ccp((screen_size.width/2.0) - 100,
                                            screen_size.height - 20);
                                                                                    
            m_score_pl1.color = ccc3(0,0,0);
            [self addChild:m_score_pl1];			
            
            m_score_pl2 = [CCLabelTTF labelWithString   :@"0" 
                                             fontName   :@"Marker Felt" 
                                            fontSize    :20.0];	
                                                                            
            m_score_pl2.position = ccp((screen_size.width/2.0) + 100,
                                        screen_size.height - 20);
                                                                                    
            m_score_pl2.color = ccc3(0,0,0);
            [self addChild:m_score_pl2];							

            m_timer_item =
                    [CCMenuItemFont itemWithString   :@"0:0"
                                            target   :self
                                          selector   :@selector(timePause)];
                                                                                            
            m_timer_item.color = ccc3(0,0,0);
            CCMenu *menu2 = [CCMenu menuWithItems:m_timer_item,nil];
            menu2.position = ccp(screen_size.width/2.0,20);
            [self addChild:menu2];
            

            CCMenuItemLabel *backMenu =
                    [CCMenuItemFont itemWithString  :@"back to menu"
                                            target  :self
                                        selector    :@selector(backToMenu)];
                                                                                                                    
            backMenu.color = ccc3(50, 50, 200);
            
            CCMenu *menu = [CCMenu menuWithItems:backMenu, nil];
            menu.position = ccp(screen_size.width/2.0,
                                screen_size.height - 20);
            [self addChild:menu];
            
            m_goal_label = [CCLabelTTF labelWithString  :@"goal" 
                                            fontName    :@"Arial"
                                            fontSize    :24];
        
            [m_goal_label setColor:ccc3(237, 2, 126)];
            
            [m_goal_label setOpacity:0];
            
            [self addChild:m_goal_label z:8];
            
            [m_phys setDefaults];
            
            [m_phys setBordersDefualt:screen_size];

            
            CCSprite *shaiba = [m_phys getObjectSprite:0];
            [self addChild:shaiba];
            
            CCSprite *klushka1 = [m_phys getPlayerSprite:PLAYER_1];
            [self addChild:klushka1];
            
            CCSprite *klushka2 = [m_phys getPlayerSprite:PLAYER_2];
            [self addChild:klushka2];
            
            [m_phys resetScene];
            

            [self schedule:@selector(updateScene:)];

            [self schedule:@selector(updateTimer:)];
            [self scheduleOnce:@selector(gotoResults) 
                                    delay:round([my_glob getTimer])];
	}
	
	return self;
}


- (void) updateScene:(ccTime) dt
{	
    [m_phys calculatePhys:dt];
    
    if ([m_phys getGoalState] == GOAL_STATE_PLAYER2) 
    {
    
        m_score_player2++;	
        m_score_pl2.string = [NSString stringWithFormat:@"%d",
                                                            m_score_player2];
                                                                                                                
        [self labelGoal    :ccp(CGRectGetMidX([m_phys getBorder:PLAYER_2_BORDER]),
                            CGRectGetMidY([m_phys getBorder:PLAYER_2_BORDER]))
                rotation    :-90.0];
                                    
    }
    
    if ([m_phys getGoalState] == GOAL_STATE_PLAYER1)
    {
    
        m_score_player1++;
        m_score_pl1.string = [NSString stringWithFormat:@"%d",
                                                           m_score_player1];
                                                                                                                
        [self labelGoal :ccp(CGRectGetMidX([m_phys getBorder:PLAYER_1_BORDER]),
                             CGRectGetMidY([m_phys getBorder:PLAYER_1_BORDER]))
                rotation:90.0];
                                    
    }
}


- (void) labelGoal:(CGPoint)pos rotation:(CGFloat)rotation
{
    [m_phys resetObjectOnly];


    [m_goal_label setPosition:pos];	

    [m_goal_label setRotation:rotation];

    id action1 = [CCFadeIn actionWithDuration:0.5];
    id action2 = [CCScaleTo actionWithDuration:0.5 scale:3.0];
    id action3 = [CCScaleTo actionWithDuration:0.5 scale:1.0];
    id action4 = [CCFadeOut actionWithDuration:0.5];

    id action5 = [CCSequence actions:[CCSpawn actions:action1,action2,nil],nil];

    id action6 = [CCRepeat actionWithAction:[CCSequence actions:action3,action2, nil] 
                                                            times:1];

    id action7 = [CCSpawn actions:action3,action4, nil];

    [m_goal_label runAction:[CCSequence actions:action5,action6,action7,nil]];


}



- (void) backToMenu
{
    if (m_paused == FALSE)
    {
        [[CCDirector sharedDirector] 
            replaceScene:[CCTransitionFade transitionWithDuration:1 
                                                            scene:[menuPlCount node]]];
    }
}


- (void) gotoResults
{
    NSString *res_message = [[NSString alloc] init];

    NSString *my_str = [[NSString alloc] init];

    if (m_score_player1 > m_score_player2) 
    {
        my_str = [NSString stringWithFormat:@"Player1 %d",
                                            m_score_player1];
                                                                                        
        res_message = [NSString stringWithFormat:@"Player1  WIN! Points:%d",
                                                m_score_player1];
    }
    
    if (m_score_player1 < m_score_player2)
    {
        my_str = [NSString stringWithFormat:@"Player2 %d",
                                            m_score_player2];
                                                                                        
        res_message = [NSString stringWithFormat:@"Player2 WIN. Points:%d",
                                                m_score_player2];
    }
    
    if (m_score_player1 == m_score_player2)
    {
        my_str = @"DRAW";
        
        res_message = [NSString stringWithFormat:@"DRAW"];
    }
 
    [my_glob addScore:my_str];
    [my_glob saveScore];	

[[CCDirector sharedDirector] 
                    replaceScene:[CCTransitionFade transitionWithDuration:1
                                  scene:[resultScene node]]];
}

- (void) timePause
{
    if (m_paused == FALSE)
    {
        [[CCDirector sharedDirector] pause];
        CGSize s = [my_glob getScreen];
        m_pause_layer = [CCLayerColor layerWithColor    :ccc4(0, 0, 0, 150) 
                                                width   :s.width 
                                                height  :s.height];
        m_pause_layer.position = CGPointZero;
        [self addChild: m_pause_layer z:8];
        
        CCMenuItemFont *_resume =
                    [CCMenuItemFont itemWithString  :@"Resume"
                                          target    :self 
                                        selector    :@selector(timeResume)];
        _resume.color = ccc3(200, 200, 20);
        
        CCMenuItemFont *_restart =
                    [CCMenuItemFont itemWithString  :@"Restart"
                                            target  :self 
                                        selector    :@selector(timeRestart)];
        _restart.color = ccc3(200, 200, 20);
        
        m_pause_menu = [CCMenu menuWithItems:_resume,_restart,nil];
        [m_pause_menu alignItemsVertically];
        m_pause_menu.position = ccp(s.width/2.0,s.height/2.0);
        [self addChild:m_pause_menu z:10];
        m_paused = TRUE;
    }
	
}

- (void) timeResume
{
	 
	[self removeChild:m_pause_layer 
			cleanup:YES];
	[self removeChild:m_pause_menu 
			cleanup:YES];
	[[CCDirector sharedDirector] resume];
	m_paused = FALSE;

}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex 
{
	if ([alertView tag] == restartAlert)
	{
		if (buttonIndex == 1) 
		{
			[self removeChild:m_pause_layer cleanup:YES];
			[self removeChild:m_pause_menu cleanup:YES];
			[[CCDirector sharedDirector] resume];
			m_paused = FALSE;
			 
			[m_phys resetScene];
			m_score_pl1.string = @"0";
			m_score_player1 = 0;
			m_score_pl2.string = @"0";
			m_score_player2 = 0; 
			m_timer_count = 0.0;
		}
	}
}


- (void) timeRestart
{
	UIAlertView *temp = 
                    [[UIAlertView alloc]
                                initWithTitle   :@"Restart"
                                    message     :@"Are you sure?"
                                    delegate    :self 
                            cancelButtonTitle   :@"No" 
                            otherButtonTitles   :@"Yes",
                                                    nil];
	[temp setTag:restartAlert];
	[temp show];
	[temp release];
}

- (void) updateTimer:(ccTime) dt
{	
	m_timer_count += dt;
	
	float temp_min = m_timer_count/60.0;
	float temp_sec = (temp_min-truncf(temp_min)) * 60.0;
	
	int r_min = round(truncf(temp_min));
	int r_sec = round(truncf(temp_sec));
	
	[m_timer_item setString:
                                [NSString stringWithFormat:@"%d:%d",
                                                            r_min,
                                                            r_sec]];
	
}

///  methods from my_phys -> GameLayer
- (int) getPlayerNumUnderPoint:(CGPoint) pos
{
	return [m_phys getPlayerNumUnderPoint:pos];
}

- (void) setPlayerUnderNum:(int)pnum pos:(CGPoint)pos
{
	if (m_paused == FALSE)
	{
		[m_phys	setPlayerUnderNum   :pnum 
                                        pos :pos];
	}
}

- (CGPoint) getObjectPosition
{
	return [m_phys getObjectPosition];
}

- (CGPoint) getPlayerPosition:(int)pnum
{
	return [m_phys getPlayerPosition:PLAYER_2];
}

- (CGFloat) getObjectSpeed
{
	return [m_phys getObjectSpeed];
}

- (CGRect) getBorder:(int) br
{
	return [m_phys getBorder:br];
}


- (void) dealloc
{
	[m_phys dealloc];
	[super dealloc];
}

@end

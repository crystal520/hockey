//
//  GameLayer_box2d.m
//  hokey_box2d
//
//  Created by admin on 10/5/12.
//  Copyright 2012 admin. All rights reserved.
//

#import "GameLayer_box2d.h"


@implementation GameLayer_box2d

+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    GameLayer_box2d *layer = [GameLayer_box2d node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

-(id) init
{
    if( (self=[super init])) {
        
        self.isTouchEnabled = YES;
            
        my_glob = [globalOptions sharedInstance];
        
        CGSize winSize = [my_glob getScreen];
            
        world = [[box2d_phys alloc] init];
        
        [world setScreenSize:winSize];
        [world setBortik:13.6f/PTM_RATIO];
        [world resetDefaults];
        [world resetBorders];
        
        CCSprite *_gamefield =
                    [[CCSprite alloc]
                         initWithFile:
                                [my_glob getTextureName:TEX_GAMEFIELD]];
        
        [_gamefield setPosition:ccp(winSize.width/2.0, winSize.height/2.0)];
        [self addChild:_gamefield];
        
        
        m_score_pl1 = [CCLabelTTF labelWithString   :@"0"
                                        fontName    :@"Marker Felt"
                                        fontSize    :20.0];
        
        m_score_pl1.position = ccp((winSize.width/2.0) - 100,
                                   winSize.height - 20);
        
        m_score_pl1.color = ccc3(0,0,0);
        [self addChild:m_score_pl1];
        
        m_score_pl2 = [CCLabelTTF labelWithString   :@"0"
                                         fontName   :@"Marker Felt"
                                        fontSize    :20.0];
        
        m_score_pl2.position = ccp((winSize.width/2.0) + 100,
                                   winSize.height - 20);
        
        m_score_pl2.color = ccc3(0,0,0);
        [self addChild:m_score_pl2];
        
        
        m_timer_item =
        [CCMenuItemFont itemWithString   :@"0:0"
                                target   :self
                              selector   :@selector(timePause)];
        
        m_timer_item.color = ccc3(0,0,0);
        CCMenu *menu2 = [CCMenu menuWithItems:m_timer_item,nil];
        menu2.position = ccp(winSize.width/2.0,20);
        [self addChild:menu2];
        
        CCMenuItemLabel *backMenu =
        [CCMenuItemFont itemWithString  :@"back to menu"
                                target  :self
                            selector    :@selector(backToMenu)];
        
        backMenu.color = ccc3(50, 50, 200);
        
        CCMenu *menu = [CCMenu menuWithItems:backMenu, nil];
        menu.position = ccp(winSize.width/2.0,
                            winSize.height - 20);
        [self addChild:menu];

        
        
        m_goal_label = [CCLabelTTF labelWithString  :@"goal"
                                        fontName    :@"Arial"
                                        fontSize    :24];
        
        [m_goal_label setColor:ccc3(237, 2, 126)];
        
        [m_goal_label setOpacity:0];
        
        [self addChild:m_goal_label z:8];
        
        
        
        
        
        CCSprite *_ball = [world getSprite:0];
        [self addChild:_ball];
        
        CCSprite *_klushka = [world getSprite:1];
        [self addChild:_klushka];
        
        CCSprite *_klushka2 = [world getSprite:2];
        [self addChild:_klushka2];
        
        [self schedule:@selector(updateScene:)];
        
        
        [self schedule:@selector(updateTimer:)];
        [self scheduleOnce:@selector(gotoResults)
                     delay:round([my_glob getTimer])];
        
    }
    return self;
}

- (void)updateScene:(ccTime) dt {
    
    [world calculateWorld:dt];
    
    if ([world getGoalState] == GOAL_STATE_PLAYER2)
    {
        m_score_player2++;
        m_score_pl2.string = [NSString stringWithFormat:@"%d",
                              m_score_player2];
        
        [self labelGoal    :ccp(CGRectGetMidX([world getBorder:PLAYER_2_BORDER]),
                                CGRectGetMidY([world getBorder:PLAYER_2_BORDER]))
               rotation    :-90.0];
        
    }
    
    if ([world getGoalState] == GOAL_STATE_PLAYER1)
    {
        
        m_score_player1++;
        m_score_pl1.string = [NSString stringWithFormat:@"%d",
                              m_score_player1];
        
        [self labelGoal :ccp(CGRectGetMidX([world getBorder:PLAYER_1_BORDER]),
                             CGRectGetMidY([world getBorder:PLAYER_1_BORDER]))
                rotation:90.0];
       
    }
}
- (void) labelGoal:(CGPoint)pos rotation:(CGFloat)rotation
{
    [world resetPosition];
    
    
    [m_goal_label setPosition:pos];
    
    [m_goal_label setRotation:rotation];
    
    id action1 = [CCFadeIn actionWithDuration:0.5];
    id action2 = [CCScaleTo actionWithDuration:0.5 scale:3.0];
    id action3 = [CCScaleTo actionWithDuration:0.5 scale:1.0];
    id action4 = [CCFadeOut actionWithDuration:0.5];
    
    id action5 = [CCSequence actions:
                                [CCSpawn actions:
                                                action1,
                                                action2,
                                                nil],
                                nil];
    
    id action6 = [CCRepeat actionWithAction:
                                [CCSequence actions:
                                                action3,
                                                action2,
                                                nil]
                                            times:1];
    
    id action7 = [CCSpawn actions:
                                action3,
                                action4,
                                nil];
    
    [m_goal_label runAction:[CCSequence actions:
                                                action5,
                                                action6,
                                                action7,
                                                nil]];
        
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

- (void) backToMenu
{

    if (m_paused == FALSE)
    {
        [[CCDirector sharedDirector]
         replaceScene:[CCTransitionFade transitionWithDuration:1
                                                         scene:[menuPlCount node]]];
    }
}



- (void) timePause
{
    if (m_paused == FALSE)
    {
        [[CCDirector sharedDirector] pause];
        CGSize s = [my_glob getScreen];
        m_pause_layer = [CCLayerColor layerWithColor    :ccc4(0, 0, 0, 150)
                                               width    :s.width
                                              height    :s.height];
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
        
        
        m_pause_menu = [CCMenu menuWithItems:
                                            _resume,
                                            _restart,
                                            nil];
        [m_pause_menu alignItemsVertically];
        m_pause_menu.position = ccp(s.width/2.0,
                                    s.height/2.0);
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
            
            [world resetPosition];
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
    [[UIAlertView alloc] initWithTitle          :@"Restart"
                              message           :@"Are you sure?"
                              delegate		:self
                       cancelButtonTitle	:@"No"
                       otherButtonTitles	:@"Yes", nil];
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


- (int) getPlayerNumUnderPoint:(CGPoint) pos
{
    return [world getPlayerNumUnderPoint:pos];
}

- (void) setPlayerUnderNum:(int)pnum pos:(CGPoint)pos
{
    if (m_paused == FALSE)
    {
        [world	setPlayerUnderNum   :pnum
                                pos :pos];
    }
}


- (CGPoint) getObjectPosition
{
    return [world getObjectPosition];
}

- (CGPoint) getPlayerPosition:(int)pnum
{
    return [world getPlayerPosition:PLAYER_2];
}

- (CGFloat) getObjectSpeed
{
    return [world getObjectSpeed];
}

- (CGRect) getBorder:(int) br
{
    return [world getBorder:br];
}


-(void) dealloc
{
    [world dealloc];
    [super dealloc];
}


@end

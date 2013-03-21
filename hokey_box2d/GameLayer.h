//
//  GameLayer.h
//  hokey5
//
//  Created by Fedor on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "globalOptions.h"
#import "MyPhys.h"
#import "menuPlCount.h"
#import "resultScene.h"




@interface GameLayer : CCLayer
{
	@private
	
	MyPhys				*m_phys;
	CCLabelTTF			*m_score_pl1;
	CCLabelTTF			*m_score_pl2;
	CCMenuItemFont                  *m_timer_item;

	int				m_score_player1;
	int                             m_score_player2;
	float				m_timer_count;
	
	CCLabelTTF			*m_goal_label;
	
	CCLayer				*m_pause_layer;
	CCMenu				*m_pause_menu;  //menu for pause
	globalOptions                   *my_glob;
	 
	BOOL				m_paused;
	 
	//alert_type                      m_alert;
	 
}

+(CCScene *) scene;

- (void)		labelGoal:(CGPoint)pos rotation:(CGFloat)rotation;


//function redeclaration for controlling m_phys from outside 

- (int)			getPlayerNumUnderPoint:(CGPoint) pos;

- (void)		setPlayerUnderNum:(int)pnum pos:(CGPoint)pos;

- (CGPoint)		getObjectPosition;

- (CGPoint)		getPlayerPosition:(int)pnum;

- (CGFloat)		getObjectSpeed;

- (CGRect)		getBorder:(int) br;

@end

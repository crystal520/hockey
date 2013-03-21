//
//  HelloWorldLayer.h
//  box2d test
//
//  Created by admin on 10/4/12.
//  Copyright admin 2012. All rights reserved.
//



// When you import this file, you import all the cocos2d classes

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "box2d_phys.h"
#import "globalOptions.h"
#import "const.h"
#import "resultScene.h"
#import "menuPlCount.h"
//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32.0

// HelloWorldLayer
@interface GameLayer_box2d : CCLayer
{
    
    box2d_phys *world;
    
    globalOptions *my_glob;
    
    
    int				m_score_player1;
    int                         m_score_player2;

    
    CCLabelTTF			*m_score_pl1;
    CCLabelTTF			*m_score_pl2;
    
    CCMenuItemFont              *m_timer_item;

    CCLayer                     *m_pause_layer;
    CCMenu                      *m_pause_menu;  //menu for pause
    BOOL                        m_paused;
    
  //  alert_type                  m_alert;
    float                       m_timer_count;
    
    CCLabelTTF			*m_goal_label;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

- (int)			getPlayerNumUnderPoint:(CGPoint) pos;

- (void)		setPlayerUnderNum:(int)pnum pos:(CGPoint)pos;

- (CGPoint)		getObjectPosition;

- (CGPoint)		getPlayerPosition:(int)pnum;

- (CGFloat)		getObjectSpeed;

- (CGRect)		getBorder:(int) br;

@end

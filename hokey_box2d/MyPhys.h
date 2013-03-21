//
//  MyPhys.h
//  hokey5
//
//  Created by Fedor on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameObj.h"
#import "cocos2d.h"
#import "const.h"
#import "globalOptions.h"
#import "VectorCalculations.h"


typedef  enum location {
			lcorner,
			lbetween,
			lfree
			}location;

@interface MyPhys : NSObject
{
    @private

    CGRect                  m_border[BORDER_RECT_COUNT];
    CGRect                  m_un_border[UN_BORDER_RECT_COUNT];

    GameObj                 *m_players[PLAYERS_COUNT];
    GameObj                 *m_objects[PHYSOBJ_COUNT];

    int                     goal_state; 
            
    VectorCalculations      *m_calc_vec;
                    
    location                m_location;

    BOOL                    m_stoptouch;


    BOOL                    m_obj_wall;
    CGPoint                 m_obj_wall_point;
    
    globalOptions           *my_glob;
}


/// Set  Defauls -->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (void)		setDefaults;
- (void)		setBordersDefualt:(CGSize) scr;

// ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




// Getter and Setter Object ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (CCSprite*)	getObjectSprite:(int)num;
- (CGPoint)		getObjectPosition;
- (CGFloat)		getObjectSpeed;
- (CGPoint)		getObjectVector;
- (GameObj*)	getPhysObj:(int)num;

- (void)		setPhysObj:(int)num phys_obj:(GameObj*)po;
//->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




// Getter and Setter Player ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (CCSprite*)	getPlayerSprite:(int)num;

- (void)		setPlayer:(int)num  player:(GameObj*)pl;
- (GameObj*)	getPlayer:(int)num;

- (void)		setPlayerPosition:(int)num pos:(CGPoint)pos;
- (CGPoint)		getPlayerPosition:(int)num;

//->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>





// Getter and Setter Border and Unborder ->>>>>>>>>>>>>>>>>>>>>>>

- (void)		setBorders:(int)num border:(CGRect)bord;
- (CGRect)		getBorder:(int)num;

- (void)		setUnBorder:(int)num unborder:(CGRect)unbord;
- (CGRect)		getUnBorder:(int)num;

//->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>





// Movements functions ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (CGPoint)		moveObj:(int)num dt:(ccTime)dt;
- (CGPoint)		movePlayer:(int)num dt:(ccTime)dt;

- (void)		movePlayerTo:(int)pnum pos:(CGPoint)pos dt:(ccTime)dt;

// ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




// Collision and Checkers  calculating here  ---------->>>>>>>>>>>
- (CGPoint)		ballAtCorner:(CGPoint)pospl;

- (void)		collisionObjBorder:(int)num	pos:(CGPoint)pos;

- (void)		collisionObjPlayer:(int)onum posobj:(CGPoint)poso pnum:(int)pnum pospl:(CGPoint)posp;

- (CGFloat)		moveFromBoard:(CGFloat)pos minpos:(CGFloat)minpos maxpos:(CGFloat)maxpos; 

- (BOOL)		objPlayerBorder:(int)pnum;
- (BOOL)		playerObjPlayer:(CGPoint)pos num:(int)num;
//   ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




// MAIN  function for calculate Physics ->>>>>>>>>>>>>>>>>>>>>>>>>>

- (void)		calculatePhys:(ccTime)dt;

//   ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>





// Touch Functions ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (int)			getPlayerNumUnderPoint:(CGPoint)pos;

- (void)		setPlayerUnderNum:(int)num pos:(CGPoint)pos;

- (void)		setPlayerTouchPosition:(int)num pos:(CGPoint)pos;

//->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



// Reset Functions and GoalState ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (void)		resetGoalState;

- (int)			getGoalState;

- (void)		resetScene;

- (void)		resetObjectOnly;

//->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



@end

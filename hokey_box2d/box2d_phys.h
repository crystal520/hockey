//
//  box2d_phys.h
//  box2d test
//
//  Created by admin on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "const.h"
#import "globalOptions.h"
#define PTM_RATIO   32.0

@interface box2d_phys : NSObject
{
    b2World     *m_world;
    
    b2Body      *m_body_ball;
    
    CCSprite    *m_ball;
     
    b2Body      *m_body_klushka[2];
    CCSprite    *m_klushka[2];
    CGPoint     m_touch[2];
    CGRect      m_border[3];
    
       
    CGSize      m_win_size;
    
    
    float       m_bortik;
    
    
    globalOptions *my_glob;
}


- (void) setScreenSize:(CGSize) sc;

- (void) setBortik:(float) bor;

- (void) resetPosition;

- (void) resetDefaults;

- (void) resetBorders;  // only for touch positing!!!!

- (void) calculateWorld:(ccTime) dt;

- (CCSprite*) getSprite:(int) num;

- (int) getPlayerNumUnderPoint:(CGPoint)pos;


- (CGFloat) moveFromBoard:(CGFloat)pos minpos:(CGFloat)minpos maxpos:(CGFloat)maxpos;


- (void) setPlayerUnderNum:(int)num pos:(CGPoint)pos;


- (void) moveTo:(int)num;

- (int) getGoalState;

- (CGRect) getBorder:(int) num;

- (CGPoint)  getObjectPosition;

- (float) getObjectSpeed;

- (CGPoint) getPlayerPosition:(int)pnum;


@end

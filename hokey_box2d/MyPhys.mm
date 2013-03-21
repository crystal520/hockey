//
//  MyPhys.m
//  hokey5
//
//  Created by Fedor on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyPhys.h"


@implementation MyPhys


- (id) init
{
	self = [super init];
	if (self) 
	{
	 
        my_glob = [globalOptions sharedInstance];
	//obj_in_wall = FALSE;
	//init players
	for (int i=0;(i < PLAYERS_COUNT);i++)
	{
		m_players[i] = [[GameObj alloc] init];
	}
	//init phys obj
	for (int i=0;(i < PHYSOBJ_COUNT);i++)
	{
		m_objects[i] = [[GameObj alloc] init];
	}
	///here initialization
	
	m_calc_vec = [[VectorCalculations alloc] init];
	m_stoptouch = TRUE;
	}
	return self;
}



/// Set  Defauls -->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (void) setDefaults;
{		
    [m_objects[0] setSprite:[my_glob getTextureName:TEX_SHAIBA]];
    [m_objects[0] setFriction:[my_glob getFriction]];
    [m_objects[0] setMass:5.0];

    [m_players[0] setSprite:[my_glob getTextureName:TEX_KLUSHKA1]];
    [m_players[0] setScale:[my_glob getRadius]];
    [m_players[0] setMass:10.0];
    
    [m_players[1] setSprite:[my_glob getTextureName:TEX_KLUSHKA2]];
    [m_players[1] setScale:[my_glob getRadius]];
    [m_players[1] setMass:10.0];
}

- (void) setBordersDefualt:(CGSize) scr
{

    CGPoint bortik = ccp(BORDER_SIZE,
                         BORDER_SIZE);

    m_border[0] = 
                    CGRectMake(
                                bortik.x,
                                bortik.y,
                                scr.width-(2*bortik.x),
                                scr.height-(2*bortik.y));

    m_border[1] = 
                    CGRectMake(
                                CGRectGetMinX(m_border[0]),
                                CGRectGetMinY(m_border[0]),
                                (CGRectGetWidth(m_border[0])/2.0),
                                CGRectGetHeight(m_border[0]));

    m_border[2] = 
                    CGRectMake(
                                CGRectGetMaxX(m_border[1]),
                                CGRectGetMinY(m_border[0]),
                                CGRectGetWidth(m_border[1]),
                                CGRectGetHeight(m_border[0]));

    m_un_border[0] = 
                    CGRectMake(
                                -UN_BORDER_POINTX,
                                 scr.height/3.0,
                                100+bortik.x+[m_objects[0] getRadius], 
                                scr.height/3.0);

    m_un_border[1] = 
            CGRectMake(
                CGRectGetMaxX(m_border[0]) - bortik.x-[m_objects[0] getRadius],
                scr.height/3.0,
                CGRectGetWidth(m_un_border[0]),
                scr.height/3.0);
}

// ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



// Getter and Setter Object ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (CCSprite*) getObjectSprite:(int)num
{
	return [m_objects[num] getSprite];
}

- (CGPoint) getObjectPosition
{
	return [m_objects[0] getPosition];
}

- (CGFloat) getObjectSpeed
{
	return [m_objects[0] getSpeed];
}

- (CGPoint) getObjectVector
{
	return [m_objects[0] getVector];
}

- (GameObj*) getPhysObj:(int)num
{
	return  m_objects[num];
}

- (void) setPhysObj:(int)num phys_obj:(GameObj*)po
{
	m_objects[num] = po;
}

//->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



// Getter and Setter Player ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (CCSprite*) getPlayerSprite:(int)num
{
	return [m_players[num] getSprite];
}

- (void) setPlayer:(int)num  player:(GameObj*)pl
{
	m_players[num] = pl;
}

- (GameObj*) getPlayer:(int)num
{
	return m_players[num];
}

- (void) setPlayerPosition:(int)num pos:(CGPoint)pos
{
	[m_players[num] setPosition:pos];
}

- (CGPoint) getPlayerPosition:(int)num
{
	return [m_players[num] getPosition];
}

//->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



// Getter and Setter Border and Unborder ->>>>>>>>>>>>>>>>>>>>>>>

- (void) setBorders:(int)num border:(CGRect)bord
{
	m_border[num] = bord;
}

- (CGRect) getBorder:(int)num;
{
	return m_border[num];
}

- (void) setUnBorder:(int)num unborder:(CGRect)unbord
{
	m_un_border[num] = unbord;
}

- (CGRect) getUnBorder:(int)num
{
	return m_un_border[num];
}

//->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




// Movements functions ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (CGPoint) moveObj:(int)num dt:(ccTime)dt
{
	CGPoint temp = [m_objects[num] getVector];
	CGFloat sp = [m_objects[num] getSpeed];
	CGPoint object_position = [m_objects[num] getPosition];
	
	CGPoint friction = ccpMult(ccpNeg(temp),[m_objects[num] getFriction]*sp);
	
	CGPoint speed = ccpMult(temp,sp);
	
	CGPoint pos = ccpAdd(object_position,(ccpMult(ccpAdd(speed,friction),dt)));
	
	return pos;
}

- (CGPoint) movePlayer:(int)num dt:(ccTime)dt
{
	CGFloat speed = [m_players[num] getSpeed];
	CGPoint vector = [m_players[num] getVector];
	CGPoint player_pos = [m_players[num] getPosition];
	
	CGPoint pos = ccpAdd(player_pos, ccpMult(vector, speed*dt));


	return pos;
}

- (void) movePlayerTo:(int)pnum pos:(CGPoint)pos dt:(ccTime)dt
{
	CGPoint last_player_position = [m_players[pnum] getPosition];
	
	CGFloat dS = ccpDistance(pos, last_player_position);
	
	CGFloat speed = dS/(dt*2.5);
	
	if (speed < 1.0)
	{
		speed = 0.0;
	}
	
	[m_players[pnum] setSpeed:speed];
	[m_players[pnum] calcVectorTo:pos];
	[m_players[pnum] setContact:[m_players[pnum] getVector]];
	[m_players[pnum] normalizeVector];
	
}

// ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




// Collision and Checkers  calculating here  ---------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (CGPoint)		ballAtCorner:(CGPoint) pospl;
{
    CGFloat temp_radius = [m_objects[0] getRadius];
    CGFloat temp_pl_radius = [m_players[0] getRadius];
    
    CGPoint pos = [m_objects[0] getPosition];
    
    CGPoint vec_out = [m_calc_vec Normal:ccpSub(pospl, pos)];
    
    CGPoint new_coord = ccpAdd(
                               ccpMult(vec_out,
                                       (temp_radius + temp_pl_radius)),
                               pos);
    
    BOOL temp = [self atCorner:pos];
    
    if (temp == true)
    {
        m_location = lcorner;
    }
    
    return new_coord;
}


- (void)    collisionObjBorder:(int)num	pos:(CGPoint)pos
{

    CGRect temp_border		= m_border[0];
    CGFloat temp_radius		= [m_objects[num] getRadius];

    CGFloat maxx = (CGRectGetMaxX(temp_border) - temp_radius);
    CGFloat minx = (CGRectGetMinX(temp_border) + temp_radius);
    CGFloat maxy = (CGRectGetMaxY(temp_border) - temp_radius);
    CGFloat miny = (CGRectGetMinY(temp_border) + temp_radius);	

										
    BOOL un_bord = FALSE;

    for (int i = 0;(i < UN_BORDER_RECT_COUNT);i++)
    {
        if (CGRectContainsPoint(m_un_border[i], pos) == TRUE) 
        {
            un_bord = TRUE;
            
            if ((pos.x < (CGRectGetMaxX(m_un_border[PLAYER_1]) - 2.0 * temp_radius))||
                (pos.x > (CGRectGetMinX(m_un_border[PLAYER_2]) + 2.0 * temp_radius)))
            {
                if (i == 0)
                {
                    goal_state = GOAL_STATE_PLAYER2;
                }
        
                if (i == 1)
                {
                    goal_state = GOAL_STATE_PLAYER1;
                }
            
            }

        }

    }

	
    CGPoint	newpos = 
                    ccp(
                            [self moveFromBoard		:pos.x 
                                                minpos	:minx
                                                maxpos	:maxx],
                                                            
                            [self moveFromBoard		:pos.y 
                                                minpos	:miny
                                                maxpos	:maxy]);

    
    BOOL corn = [self atCorner:newpos];
    // ----------------------->
    CGPoint newvec = [m_objects[num] getVector];
    if (corn == TRUE)
    {
        [m_objects[0] setSpeed:700.0];
    }	
    
    
    
    if (un_bord == FALSE)
	{		
            if	(CGPointEqualToPoint(pos, newpos) == TRUE)
            {
            // nothing  there is no collision with border
                    [m_objects[num] setContact:newvec];	
                    
                    m_obj_wall = FALSE;
                    m_obj_wall_point = CGPointZero;
            }
            else
            { 
                if (m_obj_wall == FALSE)
                {
                    m_obj_wall = TRUE;

                    m_obj_wall_point =  newpos;
                    
                    CGPoint old = pos;
                                    
                    if ((old.x > newpos.x)||
                            (old.x < newpos.x))
                    {
                        newvec.x = - newvec.x;
                    }
                    
                    if ((old.y > newpos.y)||
                            (old.y < newpos.y))
                    {
                        newvec.y = - newvec.y;
                    }
                    
                    [m_objects[num] addContact:newvec];
                }
                    
            }
            [m_objects[num] setPosition:newpos];
	}
	else
	{
            [m_objects[num] setContact:[m_objects[num] getVector]];	
            [m_objects[num] setPosition:pos];
	}
	m_location = lfree;
}



- (void)    collisionObjPlayer:(int)onum posobj:(CGPoint)poso pnum:(int)pnum pospl:(CGPoint)posp
{	
    CGFloat rad_pl	= [m_players[pnum]	getRadius];
    CGFloat rad_ob	= [m_objects[onum]	getRadius];
    
    CGFloat speed_1 = [m_objects[onum]	getSpeed];
    CGFloat speed_2 = [m_players[pnum]	getSpeed];
    
    
    CGPoint vec2	= [m_players[pnum] getVector];
    
    CGPoint vec3	= ccpSub(poso, posp);
    
    
    
    
    CGFloat speed_1_after = speed_2;
    
    if (speed_2 <= speed_1)
    {
            speed_1_after = speed_1;
    
    }
    
    if (speed_1_after > 4000.0)
    {
            speed_1_after = 4000.0;
    }
    
    
    
    
    
    if ([self objPlayerBorder:pnum]) 
    {

    }
    else
    {
        if ((ccpDistance(posp,poso)) <= (rad_ob+rad_pl))
        {
            [m_objects[onum]    addContact:vec2];
            [m_objects[onum]    addContact:vec3];
                                            
            [m_objects[onum] setSpeed:speed_1_after];
            
            CGPoint temppos1 =
                        [m_calc_vec Normal:
                                    ccpSub([m_objects[0] getPosition],
                                           posp)];
            
            CGPoint temppos2 =
                        [m_calc_vec Normal:
                                    ccpSub(posp,
                                           [m_objects[0] getPosition])];
            
            
            CGPoint newpos1 = ccpAdd(
                                    ccpMult(temppos1, (rad_ob+rad_pl)),
                                    posp);
                                                            
                                                            
            [m_objects[onum] setPosition:newpos1];
            
            
            
            [m_players[pnum] setSpeed:0.0];
            [m_players[pnum] setVector:ccp(0.0,0.0)];
            
            CGPoint newpos2 = ccpAdd(
                                    ccpMult(temppos2,1.0), 
                                    posp);
                                                            
            [m_players[pnum] setPosition:newpos2];
            [m_players[pnum] setTouchPoint:newpos2];
        }
        else
        {						
            [m_players[pnum] setPosition:posp];
                        
        }
    }
    
}


- (CGFloat) moveFromBoard:(CGFloat)pos minpos:(CGFloat)minpos maxpos:(CGFloat)maxpos;
{
	CGFloat temp = pos;
	
	if (pos < minpos)
	{
		temp = minpos;
	}
	
	if (pos > maxpos)
	{
		temp = maxpos;
	}

	return temp;
}

- (BOOL)		atCorner:(CGPoint)pos;
{
    
    CGRect temp_border = m_border[0];
    CGFloat temp_radius = [m_objects[0] getRadius];
    
    CGFloat maxx = (CGRectGetMaxX(temp_border) - temp_radius);
    CGFloat minx = (CGRectGetMinX(temp_border) + temp_radius);
    CGFloat maxy = (CGRectGetMaxY(temp_border) - temp_radius);
    CGFloat miny = (CGRectGetMinY(temp_border) + temp_radius);
    
    CGPoint	up_left = ccp(minx ,maxy);
    CGPoint	up_right = ccp(maxx ,maxy);
    CGPoint	down_left = ccp(minx ,miny);
    CGPoint	down_right = ccp(maxx ,miny);
    
    
    BOOL temp = false;
    
    if ((ccpDistance(pos, up_left) <= temp_radius)||
        (ccpDistance(pos, up_right) <= temp_radius)||
        (ccpDistance(pos, down_left) <= temp_radius)||
        (ccpDistance(pos, down_right) <= temp_radius))
    {
        temp = true;
        
    }		
    return temp;
    
}

- (BOOL)  objPlayerBorder:(int)pnum
{
    CGPoint pl_pos = [m_players[pnum] getPosition];
    
    CGFloat rad_pl	= [m_players[pnum]	getRadius];
    CGFloat rad_ob	= [m_objects[0]	getRadius];
    
    CGPoint ob_pos = [m_objects[0] getPosition];
    
    BOOL temp = false;
    //
    if ((m_obj_wall == TRUE) && (ccpDistance(pl_pos, ob_pos) <= (rad_ob+rad_pl)))
    {
            temp = true;
    }
    
    return temp;
}



- (BOOL) playerObjPlayer:(CGPoint)pos num:(int)num;
{
    int num2 = 0;
    
    if (num == PLAYER_1)
    {
            num2 = PLAYER_2;
    }
    
    if (num == PLAYER_2) 
    {
            num2 = PLAYER_1;
    }

    CGFloat rad_pl	= [m_players[PLAYER_1]	getRadius];
    CGFloat rad_ob	= [m_objects[0]	getRadius];

    CGPoint pl_pos1 = pos;
    CGPoint pl_pos2 = [m_players[num2] getPosition];
    
    CGPoint ob_pos = [m_objects[0] getPosition];
    
    
    CGFloat miny = CGRectGetMinY(m_border[0]);
    CGFloat maxy = CGRectGetMaxY(m_border[0]);
    
    BOOL  rule1 = ((ob_pos.x >= pl_pos1.x) && (ob_pos.x <= pl_pos2.x));
    
    BOOL  rule2 = (ccpDistance(pl_pos1, pl_pos2) <= (2 * rad_ob + 2 * rad_pl));
    
    BOOL  subrule31 = (ob_pos.y <= miny + rad_ob);
    BOOL  subrule32 = (ob_pos.y >= maxy - rad_ob);
    
    BOOL  rule3 = (subrule31 || subrule32); 
    
    //	NSLog(@"r1=%d, r2=%d, r3=%d", rule1,rule2,rule3);

    return (rule1 && rule2 && rule3);
}


//   ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>





// MAIN  function for calculate Physics ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


- (void) calculatePhys:(ccTime)dt
{
    m_stoptouch = TRUE;
    CGPoint temp[4];

    temp[0] = [self moveObj	:0 
                            dt	:dt];
                                            

    [self collisionObjBorder	:0 
                        pos     :temp[0]];
                                            
            
    [self movePlayerTo	:PLAYER_1		
                    pos	:[m_players[PLAYER_1] getTouchPoint] 
                    dt	:dt];

    temp[1] = [self movePlayer	:PLAYER_1 
                            dt	:dt];		
                                                                                                                                                                                            
    [self movePlayerTo	:PLAYER_2		
                    pos	:[m_players[PLAYER_2] getTouchPoint] 
                    dt	:dt];
                                    
    temp[2] = [self movePlayer	:PLAYER_2 
                            dt	:dt];
                                            

    [self collisionObjPlayer	:0 
                        posobj	:temp[0] 
                        pnum	:PLAYER_1 
                        pospl	:temp[1]];	
            
    [self collisionObjPlayer	:0 
                        posobj	:temp[0] 
                        pnum	:PLAYER_2
                        pospl	:temp[2]];	
                                                            
    [m_objects[0] contactToVector];		

    [m_objects[0] normalizeVector];

    [m_objects[0] changeSpeedByFriction];

    [m_objects[0] resetContact];

    m_stoptouch = FALSE;
}

//   ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>





// Touch Functions ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (int) getPlayerNumUnderPoint:(CGPoint)pos;
{
    int  i = NO_BODY_AT_POINT;

    if (CGRectContainsPoint(m_border[PLAYER_1_BORDER], pos) == TRUE)
    {
            i = PLAYER_1_AT_POINT;
    }
    if (CGRectContainsPoint(m_border[PLAYER_2_BORDER], pos) == TRUE)
    {
            i = PLAYER_2_AT_POINT;
    }	

    return i;
}

- (void) setPlayerUnderNum:(int)num pos:(CGPoint)pos
{		
    if (m_stoptouch == FALSE)
    {
        pos.x =
                [self moveFromBoard	:pos.x 

                            minpos	:(CGRectGetMinX(m_border[num+1]) + 
                                          [m_players[num] getRadius]) 
                                                      
                            maxpos	:(CGRectGetMaxX(m_border[num+1]) - 
                                          [m_players[num] getRadius])];

        pos.y =
                [self moveFromBoard	:pos.y 
                
                            minpos	:(CGRectGetMinY(m_border[num+1]) + 
                                          [m_players[num] getRadius]) 
                                                      
                            maxpos	:(CGRectGetMaxY(m_border[num+1]) - 
                                          [m_players[num] getRadius])];



        CGPoint pos_obj = [m_objects[0] getPosition];
        CGFloat rad_obj = [m_objects[0] getRadius];
        CGFloat rad_pl  = [m_players[num] getRadius];
        
        CGPoint newpos	= [self ballAtCorner:pos];
        
        
        if ([self playerObjPlayer:pos num:num]) 
        {
            CGPoint tempdist = [m_calc_vec Normal:ccpSub(pos, pos_obj)];
            
            CGPoint newpos = ccpAdd(
                                    ccpMult(tempdist, rad_pl + rad_obj),
                                    pos_obj);
            
            [m_players[num] setTouchPoint:newpos];
        }
        else
        {
            if ((m_location == lcorner)&&
                (ccpDistance(pos_obj, pos) <= (rad_pl + rad_obj)))
            {
                [m_players[num] setTouchPoint:newpos];	
            }
            
            else
            {	
                [m_players[num] setTouchPoint:pos];
            }
        }
    }
}

- (void) setPlayerTouchPosition:(int)num pos:(CGPoint)pos
{
	[m_players[num] setTouchPoint:pos];
}

//->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



// Reset Functions and GoalState ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

- (void) resetGoalState
{
	goal_state = GOAL_STATE_NOBODY;
}
- (int) getGoalState
{
	return goal_state;
}

- (void) resetScene
{
    goal_state = GOAL_STATE_NOBODY;

    //shaiba
    [m_objects[0] 
            setPosition:
                        ccp(
                            CGRectGetMidX(m_border[0]),
                            CGRectGetMidY(m_border[0]))];
                                                    
    [m_objects[0] setSpeed:500.0];
    [m_objects[0] setVector:ccp(0.7,0.6)];
    [m_objects[0] resetContact];
    [m_objects[0] setContact:[m_objects[0] getVector]];


    //klushka1
    [m_players[PLAYER_1] 
                     setPosition:
                        ccp(
                            CGRectGetMidX(m_border[0]) -
                                        [m_players[PLAYER_1] getRadius] * 2.0,
                            CGRectGetMidY(m_border[0]))];
                                    
    [m_players[PLAYER_1] setSpeed:0.0];
    [m_players[PLAYER_1] setVector:ccp(0.0,0.0)];
    [m_players[PLAYER_1] setTouchPoint:[m_players[PLAYER_1] getPosition]];
    //klushka2
    [m_players[PLAYER_2] 
                    setPosition:
                        ccp(
                            CGRectGetMidX(m_border[0]) +
                                        [m_players[PLAYER_2] getRadius] * 2.0,
                            CGRectGetMidY(m_border[0]))];
                                                    
    [m_players[PLAYER_2] setSpeed:0.0];
    [m_players[PLAYER_2] setVector:ccp(0.0,0.0)];
    [m_players[PLAYER_2] setTouchPoint:[m_players[PLAYER_2] getPosition]];
}

- (void) resetObjectOnly
{
    goal_state = GOAL_STATE_NOBODY;

    [m_objects[0] 
            setPosition:
                        ccp(
                            CGRectGetMidX(m_border[0]),
                            CGRectGetMidY(m_border[0]))];

    [m_objects[0] setSpeed:0.0];
    [m_objects[0] setVector:ccp(0.0,0.0)];

    [m_players[PLAYER_1] setSpeed:0.0];
    [m_players[PLAYER_1] setVector:ccp(0.0,0.0)];

    [m_players[PLAYER_2] setSpeed:0.0];
    [m_players[PLAYER_2] setVector:ccp(0.0,0.0)];
}
//->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


///----------------DEALLOC
- (void) dealloc
{
    //init players
    for (int i = 0;(i < PLAYERS_COUNT);i++)
    {
        [m_players[i] dealloc];
    }
    //init phys obj
    for (int i = 0;(i < PHYSOBJ_COUNT);i++)
    {
        [m_objects[i] dealloc];
    }

    [m_calc_vec dealloc];
    [super dealloc];
}

@end

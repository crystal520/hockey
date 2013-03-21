//
//  box2d_phys.mm
//  box2d test
//
//  Created by admin on 10/5/12.
//  Copyright (c) 2012 admin. All rights reserved.
//

#import "box2d_phys.h"

@implementation box2d_phys


- (id) init
{
    self = [super init];
    if (self)
    {
        
        my_glob = [globalOptions sharedInstance];
        
        // Create sprite and add it to the layer
        m_ball =
        [[CCSprite alloc] initWithFile:[my_glob getTextureName:TEX_SHAIBA]];
       

        m_klushka[0] =
        [[CCSprite alloc] initWithFile:[my_glob getTextureName:TEX_KLUSHKA1]];
        [m_klushka[0] setScale:[my_glob getRadius]];
                    
        
        m_klushka[1] =
        [[CCSprite alloc] initWithFile:[my_glob getTextureName:TEX_KLUSHKA2]];
        [m_klushka[1] setScale:[my_glob getRadius]];
        
    }
    
    
    return self;
    
    
    
}



- (void) setScreenSize:(CGSize) sc
{
    m_win_size = sc;
}

- (void) setBortik:(float) bor
{
    m_bortik = bor;
}

- (void) resetPosition
{
    m_body_ball->SetLinearVelocity(b2Vec2_zero);
    m_body_ball->SetTransform(b2Vec2((m_win_size.width/2.0f)/PTM_RATIO,
                                     (m_win_size.height/2.0f)/PTM_RATIO),
                              m_body_ball->GetAngle());
}




- (void) resetDefaults
{
    
       
    CGSize _ball_radius = m_ball.contentSize;
    
    CGSize _klushka_radius =
        CGSizeMake(m_klushka[0].contentSize.width * [my_glob getRadius],
                    m_klushka[0].contentSize.height * [my_glob getRadius]);
    
    CGSize _klushka2_radius =
            CGSizeMake(m_klushka[1].contentSize.width * [my_glob getRadius],
                       m_klushka[1].contentSize.height * [my_glob getRadius]);
    
    m_ball.position = ccp(m_win_size.width/2.0f,
                          m_win_size.height/2.0f);
    
    m_klushka[0].position = ccp(m_win_size.width/3.0f,
                                m_win_size.height/2.0f);
   
    m_klushka[1].position = ccp((2.0f*m_win_size.width)/3.0f,
                                m_win_size.height/2.0f);
    
    // Create a world
    b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
    m_world = new b2World(gravity);
    
    
    // Create ball body and shape
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    
    ballBodyDef.position.Set(m_ball.position.x/PTM_RATIO,
                             m_ball.position.y/PTM_RATIO);
    
    ballBodyDef.userData = m_ball;
    m_body_ball = m_world->CreateBody(&ballBodyDef);
    
    b2CircleShape circle;
    circle.m_radius = _ball_radius.width/(PTM_RATIO*2.0f);
    //circle.m_radius = 26.0/PTM_RATIO;
    
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &circle;
    ballShapeDef.density = 1.0f;
    ballShapeDef.friction = [my_glob getFriction]*10.0;
    ballShapeDef.restitution = 1.0f;
    m_body_ball->CreateFixture(&ballShapeDef);
    m_body_ball->SetBullet(true);
    
    
    m_touch[1] = m_klushka[1].position;
    m_touch[0] = m_klushka[0].position;
    
    
    // Create klushka body and shape
    b2BodyDef klushkaBodyDef;
    klushkaBodyDef.type = b2_dynamicBody;
    
    klushkaBodyDef.position.Set(m_klushka[0].position.x/PTM_RATIO,
                                m_klushka[0].position.y/PTM_RATIO);
    
    klushkaBodyDef.userData = m_klushka[0];
    m_body_klushka[0] = m_world->CreateBody(&klushkaBodyDef);
    
    b2CircleShape circle2;
    //circle2.m_radius = 50.0/PTM_RATIO;
    circle2.m_radius = _klushka_radius.width/(PTM_RATIO*2.0f);
    
    b2FixtureDef klushkaShapeDef;
    klushkaShapeDef.shape = &circle2;
    klushkaShapeDef.density = 10.0f;
    klushkaShapeDef.friction = 1.0f;
    klushkaShapeDef.restitution = 0.0f;
    
    m_body_klushka[0]->CreateFixture(&klushkaShapeDef);
    
    
    // Create klushka2 body and shape
    b2BodyDef klushka2BodyDef;
    klushka2BodyDef.type = b2_dynamicBody;
    
    klushka2BodyDef.position.Set(m_klushka[1].position.x/PTM_RATIO,
                                m_klushka[1].position.y/PTM_RATIO);
    
    
    
    klushka2BodyDef.userData = m_klushka[1];
    m_body_klushka[1] = m_world->CreateBody(&klushka2BodyDef);
    
    b2CircleShape circle3;
    //circle2.m_radius = 50.0/PTM_RATIO;
    circle3.m_radius = _klushka2_radius.width/(PTM_RATIO*2.0f);

    b2FixtureDef klushka2ShapeDef;
    klushka2ShapeDef.shape = &circle3;
    klushka2ShapeDef.density = 10.0f;
    klushka2ShapeDef.friction = 1.0f;
    klushka2ShapeDef.restitution = 0.0f;
    
    m_body_klushka[1]->CreateFixture(&klushka2ShapeDef);
}

- (void) resetBorders
{

m_border[0] =
CGRectMake(
           0.0,
           0.0,
           m_win_size.width,
           m_win_size.height);

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
  
    
    
    
    // Create edges around the entire screen
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0,0);
    b2Body *groundBody = m_world->CreateBody(&groundBodyDef);
    b2EdgeShape groundEdge;
    b2FixtureDef boxShapeDef;
    boxShapeDef.shape = &groundEdge;
    
    
    
    //left_corner
    groundEdge.Set(b2Vec2(0.0f + m_bortik,
                          BORDER_CORNER * m_bortik),
                   b2Vec2(BORDER_CORNER * m_bortik,
                          0.0f + m_bortik));
    groundBody->CreateFixture(&boxShapeDef);
    
    groundEdge.Set(b2Vec2(BORDER_CORNER * m_bortik,
                          0.0f + m_bortik),
                   b2Vec2((m_win_size.width/PTM_RATIO) - BORDER_CORNER * m_bortik,
                          0.0f + m_bortik));
    groundBody->CreateFixture(&boxShapeDef);
    
    
    /// ------- gate left
    
    groundEdge.Set(b2Vec2(0.0f + m_bortik,
                          0.0f * m_bortik),
                   b2Vec2(0.0f + m_bortik,
                          (m_win_size.height/3.0)/PTM_RATIO));
    groundBody->CreateFixture(&boxShapeDef);
    //bortikki vorot
    
    groundEdge.Set(b2Vec2(0.0f + m_bortik,
                          (m_win_size.height/3.0)/PTM_RATIO),
                   b2Vec2(-100.0f,
                          (m_win_size.height/3.0)/PTM_RATIO));
    groundBody->CreateFixture(&boxShapeDef);

    
    groundEdge.Set(b2Vec2(0.0f + m_bortik,
                          (2.0 * m_win_size.height/3.0)/PTM_RATIO),
                   b2Vec2(-100.0f,
                          (2.0 * m_win_size.height/3.0)/PTM_RATIO));
    groundBody->CreateFixture(&boxShapeDef);
    
    //bortiki vorot
    groundEdge.Set(b2Vec2(0.0f + m_bortik,
                         ((2.0 * m_win_size.height/3.0)/PTM_RATIO) - 0.0f * m_bortik),
                   b2Vec2(0.0f + m_bortik,
                          (m_win_size.height/PTM_RATIO) - 0.0f * m_bortik));
    groundBody->CreateFixture(&boxShapeDef);
    
    ///--------gate left
    
    
    groundEdge.Set(b2Vec2(0.0f + m_bortik,
                          (m_win_size.height/PTM_RATIO) - BORDER_CORNER * m_bortik),
                   b2Vec2(BORDER_CORNER * m_bortik,
                          (m_win_size.height/PTM_RATIO) - m_bortik));
    groundBody->CreateFixture(&boxShapeDef);
    
    
    groundEdge.Set(b2Vec2(0.0f + BORDER_CORNER * m_bortik,
                          (m_win_size.height/PTM_RATIO) - m_bortik),
                   b2Vec2((m_win_size.width/PTM_RATIO) - BORDER_CORNER * m_bortik,
                          (m_win_size.height/PTM_RATIO) - m_bortik));
    groundBody->CreateFixture(&boxShapeDef);
    
    
    groundEdge.Set(b2Vec2((m_win_size.width/PTM_RATIO) - BORDER_CORNER * m_bortik,
                          (m_win_size.height/PTM_RATIO) - m_bortik),
                   b2Vec2((m_win_size.width/PTM_RATIO) - m_bortik,
                          (m_win_size.height/PTM_RATIO) - BORDER_CORNER * m_bortik));
    groundBody->CreateFixture(&boxShapeDef);
    
    
    ///gate right
    
    
    groundEdge.Set(b2Vec2((m_win_size.width/PTM_RATIO) - m_bortik,
                          0.0f * m_bortik),
                   b2Vec2((m_win_size.width/PTM_RATIO) - m_bortik,
                          (m_win_size.height/3.0)/PTM_RATIO));
    groundBody->CreateFixture(&boxShapeDef);
    //bortikki vorot
    
    groundEdge.Set(b2Vec2((m_win_size.width/PTM_RATIO) - m_bortik,
                          (m_win_size.height/3.0)/PTM_RATIO),
                   b2Vec2(100.0f + (m_win_size.width/PTM_RATIO) - m_bortik,
                          (m_win_size.height/3.0)/PTM_RATIO));
    groundBody->CreateFixture(&boxShapeDef);
    
    
    groundEdge.Set(b2Vec2((m_win_size.width/PTM_RATIO) - m_bortik,
                          (2.0f * m_win_size.height/3.0)/PTM_RATIO),
                   b2Vec2(100.0f + (m_win_size.width/PTM_RATIO),
                          (BORDER_CORNER * m_win_size.height/3.0)/PTM_RATIO));
    groundBody->CreateFixture(&boxShapeDef);
    
    //bortiki vorot
    groundEdge.Set(b2Vec2((m_win_size.width/PTM_RATIO) - m_bortik,
                          ((2.0f * m_win_size.height/3.0)/PTM_RATIO) - 0.0f * m_bortik),
                   b2Vec2((m_win_size.width/PTM_RATIO) - m_bortik,
                          (m_win_size.height/PTM_RATIO) - 0.0f * m_bortik));
    groundBody->CreateFixture(&boxShapeDef);
    
    //gate right 
    
    
    
    groundEdge.Set(b2Vec2((m_win_size.width/PTM_RATIO) - m_bortik,
                          0.0f + BORDER_CORNER * m_bortik),
                   b2Vec2((m_win_size.width/PTM_RATIO) - BORDER_CORNER * m_bortik,
                          0.0f + m_bortik));
    groundBody->CreateFixture(&boxShapeDef);

   
}




- (void) calculateWorld:(ccTime) dt;
{
        [self moveTo:1];
    
    
    m_world->Step(dt, 100, 100);
    for(b2Body *b = m_world->GetBodyList(); b; b=b->GetNext())
    {
        if (b->GetUserData() != NULL)
        {
            
            CCSprite *objData = (CCSprite *)b->GetUserData();
            objData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                    b->GetPosition().y * PTM_RATIO);
        
            b->SetLinearDamping([my_glob getFriction]*10.0);
            //  objData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
        }
    }
}


- (CCSprite*) getSprite:(int) num;
{
    CCSprite *temp;
    
    if (num == 0)
    {
        temp = m_ball;
    }
    
    if (num == 1)
    {
        temp = m_klushka[0];
    }
    
    if (num == 2)
    {
        temp = m_klushka[1];
    }
    
    return temp;
}


- (int) getPlayerNumUnderPoint:(CGPoint)pos
{
    int  i = NO_BODY_AT_POINT;
    
    if (CGRectContainsPoint(m_border[PLAYER_1], pos) == TRUE)
    {
        i = PLAYER_1_AT_POINT;
    }
    if (CGRectContainsPoint(m_border[2], pos) == TRUE)
    {
        i = PLAYER_2_AT_POINT;
    }	
    
    return i;
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




- (void) setPlayerUnderNum:(int)num pos:(CGPoint)pos
{
    
    pos.x =
    [self moveFromBoard	:pos.x
     
                 minpos	:(CGRectGetMinX(m_border[num+1]) +
                              ((m_klushka[num].contentSize.width *
                                          [my_glob getRadius])/2.0))
     
                 maxpos	:(CGRectGetMaxX(m_border[num+1]) -
                              ((m_klushka[num].contentSize.width *
                                          [my_glob getRadius])/2.0))];

    /* pos.y =
    [self moveFromBoard	:pos.y
     
                 minpos	:(CGRectGetMinY(m_border[num]) -
                              _klushka.contentSize.height)
     
                 maxpos	:CGRectGetMaxY(m_border[num])];

    */

    m_touch[num] = pos;

    
 
}


- (void) moveTo:(int)num
{
        
    for (int i=0 ; i<2; i++)
    {
        
        b2Vec2 coord = b2Vec2(m_touch[i].x/PTM_RATIO,
                              m_touch[i].y/PTM_RATIO);
    
        m_body_klushka[i] ->SetSleepingAllowed(true);

        b2Vec2 pos = b2Vec2(m_body_klushka[i]->GetPosition().x,
                            m_body_klushka[i]->GetPosition().y);
        
        b2Vec2 velocity = coord - pos;
        
        velocity *= 10.0;
        m_body_klushka[i]->SetLinearVelocity(velocity);
        
        //_body_klushka->ApplyLinearImpulse(impulse, coord);
        //_body_klushka->SetTransform(coord, _body_klushka->GetAngle());
        // _body_klushka->ApplyLinearImpulse(impulse,
        //                                 pos);
        
        m_body_klushka[i]->SetSleepingAllowed(false);
     
    }
         
}

- (int) getGoalState
{
    int goal_state;
    
    goal_state = 0;
    
    float temp = m_body_ball->GetPosition().x;
    float max = CGRectGetMaxX(m_border[0])/PTM_RATIO;
    float min = CGRectGetMinX(m_border[0])/PTM_RATIO;
        
    if(temp < min)
    {
        goal_state = -1;
    }
    
    if (temp > max)
    {
        goal_state = 1;
    }
    
    return goal_state;
}

- (CGRect) getBorder:(int) num
{
    return m_border[num];
}


- (CGPoint) getObjectPosition
{
    b2Vec2 ps = m_body_ball->GetPosition();
    
    CGPoint coord = ccp(ps.x * PTM_RATIO , ps.y * PTM_RATIO);
    
    return coord;
}

- (float) getObjectSpeed
{
    b2Vec2 speed = m_body_ball->GetLinearVelocity();
    
    float temp = ccpLength(ccp(speed.x * PTM_RATIO, speed.y * PTM_RATIO));
    
    return temp;
}
    
- (CGPoint) getPlayerPosition:(int)pnum
{
    b2Vec2 ps = m_body_klushka[pnum]->GetPosition();
    
    CGPoint coord = ccp(ps.x * PTM_RATIO , ps.y * PTM_RATIO);
    
    return coord;
}

-(void) dealloc
{
    
    delete m_world;
    m_body_ball = NULL;
    m_body_klushka[0] = NULL;
    m_body_klushka[1] = NULL;
    m_world = NULL;
    
    [super dealloc];
}




@end

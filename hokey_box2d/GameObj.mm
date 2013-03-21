//
//  GameObj.m
//  hokey5
//
//  Created by Fedor on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObj.h"


@implementation GameObj


- (id) init
{
	self = [super init];
	if (self) 
	{
		m_scale = 1.0;
		m_calc_vec = [[VectorCalculations alloc] init];
	}
	return self;
}

- (void) setPosition:(CGPoint)pos
{
	m_pos = pos;
	m_sp.position = pos;
}


- (CGPoint) getPosition;
{
	return m_pos;
}

- (void) setSprite:(NSString*)path
{
	m_sp = [[CCSprite alloc] initWithFile:path];
	m_radius = ([m_sp contentSize].height)/2.0;
}

- (CCSprite*) getSprite
{
	return m_sp;
}

- (void) setScale:(CGFloat)sc
{
	[m_sp setScale:sc];
	m_radius = ([m_sp contentSize].height*sc)/2.0;
}

- (CGFloat) getScale
{
	return m_scale;
}


- (void) setMass:(CGFloat)mas
{
	m_mas = mas;
}

- (CGFloat) getMass
{
	return m_mas;
}

- (void) setSpeed:(CGFloat)sp
{
	m_speed = sp;
}
- (CGFloat) getSpeed
{
	return m_speed;
}

- (void) setVector:(CGPoint)vec;
{
	m_vector = vec;
}

- (void) setFriction:(CGFloat)fr
{
	m_friction = fr;
}

- (CGFloat) getFriction
{
	return m_friction;
}

- (CGPoint) getVector
{
	return m_vector;
}

- (CGFloat) getRadius
{
	return	m_radius;
}

- (void) setTouchPoint:(CGPoint)pos
{
	m_pos_touch = pos;
}

- (CGPoint) getTouchPoint
{
	return m_pos_touch;
}

- (void) setX:(CGFloat)x
{
	m_pos.x  = x;
}

- (CGFloat) getX
{
	return m_pos.x;
}

- (void) setY:(CGFloat)x
{
	m_pos.y = x;
}

- (CGFloat) getY
{
	return m_pos.y;
}

- (void)		setContact:(CGPoint)pos
{
	m_contact = pos;
}

- (void)		addContact:(CGPoint) vec
{
		CGPoint  temp  = [m_calc_vec Normal:vec];

		m_contact.x += temp.x;

		m_contact.y += temp.y;
}



- (void)		setContactAtPos:(CGPoint)pos vec:(CGPoint)vec
{ 

	if (pos.x > m_pos.x)
	{
		m_contact.x += vec.x;
	}
	
	if (pos.x < m_pos.x)
	{
		m_contact.x += -vec.x;
	}
	
	if (pos.y < m_pos.y)
	{
		m_contact.y += -vec.y;
	}
	
	if (pos.y > m_pos.y)
	{
		m_contact.y += vec.y;
	}
	
}
- (CGPoint)		getContact
{
	return m_contact;
}

- (CGFloat)		getContactX
{
	return m_contact.x;
}

- (CGFloat)		getContactY
{
	return m_contact.y;
}

- (void)	resetContact

{
	m_contact = CGPointZero;
}

- (void)		contactToVector
{
	m_vector = m_contact;
}



- (void) invertVectorX
{
	m_vector.x = -m_vector.x;
}

- (void) invertVectorY
{
	m_vector.y = -m_vector.y;
}



- (void) normalizeVector
{
	m_vector = [m_calc_vec Normal:m_vector];
}

- (CGPoint) unNormalVector
{
	return ccpMult(m_vector, m_speed);
}

- (void) calcSpeed:(CGPoint)newpoint
{
	m_speed = ccpDistance(newpoint,m_pos);
}

- (void) calcVectorTo:(CGPoint) newpoint
{
	m_vector = ccpSub(newpoint, m_pos);
}

- (void) changeSpeedByFriction
{
	m_speed = m_speed - m_speed * m_friction;
}

- (void) dealloc
{
	[m_calc_vec dealloc];

	[super dealloc];
}

@end

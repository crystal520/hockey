//
//  GameObj.h
//  hokey5
//
//  Created by Fedor on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "const.h"
#import "VectorCalculations.h"


//circled game obj


@interface GameObj : NSObject
{
 @private
  CGPoint		m_pos; //coordinates ceter o
  CGFloat		m_radius; //radius
  CGFloat		m_mas;
  CGPoint		m_vector;
  CGFloat		m_speed;
  CGFloat		m_scale; 
  CGFloat		m_friction; //coefficient of friction
  CCSprite		*m_sp;
  CGPoint		m_pos_touch;
  
  CGPoint		m_contact;
    
  VectorCalculations	*m_calc_vec;
}


- (void)		setPosition:(CGPoint)pos;
- (CGPoint)		getPosition;

- (void)		setSprite:(NSString*)path;
- (CCSprite*)	getSprite;

- (void)		setScale:(CGFloat)sc;
- (CGFloat)		getScale;

- (void)		setMass:(CGFloat)mas;
- (CGFloat)		getMass;

- (void)		setSpeed:(CGFloat)sp;
- (CGFloat)		getSpeed;

- (void)		setVector:(CGPoint)vec;
- (CGPoint)		getVector;

- (void)		setFriction:(CGFloat)fr;
- (CGFloat)		getFriction;

- (void)		setTouchPoint:(CGPoint)pos;
- (CGPoint)		getTouchPoint;

- (void)		setX:(CGFloat)x;
- (CGFloat)		getX;

- (void)		setY:(CGFloat)x;
- (CGFloat)		getY;

- (CGFloat)		getRadius;

//contact functions

- (void)		setContact:(CGPoint)pos;
- (void)		addContact:(CGPoint) vec;

- (void)		setContactAtPos:(CGPoint)pos vec:(CGPoint)vec;

- (CGPoint)		getContact;
- (CGFloat)		getContactX;
- (CGFloat)		getContactY;
- (void)		resetContact;
- (void)		contactToVector;
///class calculating functions

- (void)		invertVectorX;
- (void)		invertVectorY;
- (void)		normalizeVector;
- (CGPoint)		unNormalVector;
- (void)		calcSpeed:(CGPoint)newpoint;
- (void)		calcVectorTo:(CGPoint) newpoint;

- (void)		changeSpeedByFriction;

@end

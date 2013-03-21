//
//  VectorCalculations.h
//  hokey5
//
//  Created by Fedor on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface VectorCalculations : NSObject

- (CGPoint) invertVectorX:(CGPoint)vec;
- (CGPoint) invertVectorY:(CGPoint)vec;
- (CGPoint) Normal:(CGPoint)vec;
- (CGPoint) unNormal:(CGPoint)vec len:(CGFloat)len;
- (CGPoint) calcVectorFromTo:(CGPoint)from to:(CGPoint)to;
- (CGPoint) invertVectorFromLine:(CGPoint)vec a:(CGPoint)a b:(CGPoint)b;

@end

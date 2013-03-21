//
//  VectorCalculations.m
//  hokey5
//
//  Created by Fedor on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VectorCalculations.h"

@implementation VectorCalculations





- (CGPoint) invertVectorX:(CGPoint)vec
{
	//DESTROY
	
    return ccp(-vec.x,vec.y);
}

- (CGPoint) invertVectorY:(CGPoint)vec
{
	//DESTROY

	return ccp(vec.x,-vec.y);
}




- (CGPoint)		Normal:(CGPoint)vec
{
    CGFloat len = ccpLength(vec);
    
    CGPoint result = CGPointZero;
    
    if (len == 0.0)
    {
            //result = CGPointZero;
    }
    
    else
    {

        if (len <= 1.0)
        {
            result = vec;			
        }
        else
        {
            result = ccpNormalize(vec);
        }
            
    }
    
    return result;
}



- (CGPoint)		unNormal:(CGPoint)vec len:(CGFloat)len
{
    //DESTROY

    return ccp(vec.x * len,
               vec.y * len);
}



- (CGPoint)		calcVectorFromTo:(CGPoint)from to:(CGPoint)to
{
    //DESTROY

    // add_fix mult and normal ?

    // ccpMult ( ccpNormal( ccpSub(from,to)), lenght)



    return ccp(
                            to.x - from.x,
                            to.y - from.y);
}


- (CGPoint) invertVectorFromLine:(CGPoint)vec a:(CGPoint)a b:(CGPoint)b
{		
    // TO DELETE


    // cos90=0 sin90=1||-1
    // x = ax+(bx-ax)cosa-(by-ay)sina
    // y = ay+(by-ay)cosa+(bx-ax)sina
    
    
    CGPoint newb = ccp(a.x - b.y - a.y,
                                            a.y + b.x - a.x);
    
    CGPoint perp = [self Normal:ccpSub(newb, a)];
    
    CGPoint result = [self Normal:ccpMult(ccpAdd([self Normal:vec], perp), 0.5)];		
    
    return result;
}

@end

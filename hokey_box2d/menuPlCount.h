//
//  menuPlCount.h
//  hokey5
//
//  Created by Fedor on 9/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "HelloWorldLayer.h"
#import "GamePL.h"
#import "GameAI.h"
#import "globalOptions.h"
#import "GameLayer_box2d.h"
@interface menuPlCount : CCLayer 
{
   @private
    globalOptions *my_glob;
    
}

+(CCScene *) scene;

@end

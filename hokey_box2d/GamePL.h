//
//  GamePL.h
//  hokey5
//
//  Created by Fedor on 9/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "GameLayer.h"
#import "GameLayer_box2d.h"
#import "globalOptions.h"


@interface GamePL : CCLayer 
{
    @private

    id m_game_layer;

    NSUInteger	m_touch_hash[2];
    BOOL		m_touch_active[2];
    
    globalOptions *my_glob;
}

+(CCScene *)	scene;

@end

//
//  Game.h
//  hokey5
//
//  Created by Fedor on 9/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "GameLayer.h"
#import "GameLayer_box2d.h"
#import "globalOptions.h"



@interface GameAI : CCLayer 
{
    @private

    id              m_game_layer;

    globalOptions   *my_glob;

}

+(CCScene *)	scene;

@end
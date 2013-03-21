//
//  HelloWorldLayer.h
//  hokey5
//
//  Created by Fedor on 9/13/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "menuPlCount.h"
#import "menuOpt.h"
#import "resultScene.h"
#import "cocos2d.h"
#import "globalOptions.h"

@interface HelloWorldLayer : CCLayer
{
    CCSprite	*m_spritelabelmax;
    CCSprite	*m_spritelabellast;
    
    CCLabelTTF	*m_labelmax;
    CCLabelTTF	*m_labellast;
}

+(CCScene *)	scene;

@end

//
//  menuOpt.h
//  hokey5
//
//  Created by Fedor on 9/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldLayer.h"
#import "globalOptions.h"


@interface menuOpt : CCLayer 
{
    @private

    UISlider		*m_sliderFric;
    UISlider		*m_sliderTime;
    UISlider		*m_sliderRadius;
    globalOptions       *my_glob;
    CCLabelTTF		*m_fric_label;
    CCLabelTTF		*m_time_label;
    CCLabelTTF		*m_radius_label;

    CCSprite            *m_sprite;
	
}

+(CCScene *) scene;

@end

//
//  resultScene.m
//  hokey5
//
//  Created by Fedor on 9/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "resultScene.h"


@implementation resultScene

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	resultScene *layer = [resultScene node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) 
    {	
        self.isTouchEnabled = YES;
        
        globalOptions *my_glob = [globalOptions sharedInstance];
        
        CGSize screen_size = [my_glob getScreen];	
        
        CCMenuItemLabel *exitgame =
        [CCMenuItemFont	itemWithString	:@"Back"
                            target	:self 
                            selector    :@selector(backGame)];
        exitgame.color = ccc3(255, 255, 55);
        
        
        CCMenu *menu = [CCMenu menuWithItems:exitgame ,nil];
        
        [menu setPosition:ccp((screen_size.width/2.0),
                              (screen_size.height/2.0))];
        
        [self addChild:menu];


        
        NSArray *tmp = [my_glob getScore];

        for (int i=0;i<[tmp count];i++)
        {
            NSString *titem = [tmp objectAtIndex:i];
            
            NSString *tstr = [NSString stringWithFormat:@"%d. %@",
                                                            i,
                                                            titem];
            
            
            CCLabelTTF *result = [CCLabelTTF labelWithString	:tstr 
                                                    fontName	:@"Marker Felt"
                                                    fontSize	:24];
                                                                                            
            [result setHorizontalAlignment:kCCTextAlignmentCenter];							
            [result setIgnoreAnchorPointForPosition:YES];
            
            [result setPosition:ccp(100.0,
                                    (screen_size.height - 24.0) -
                                                i *
                                                30.0)];
                
            result.color =ccc3(255, 255, 89);
            [self addChild:result];
        }

                        
        
    }
    return self;
}

- (void) backGame
{
    [[CCDirector sharedDirector] 
        replaceScene:[CCTransitionFade
                transitionWithDuration	:1
                                scene	:[HelloWorldLayer node]]];
}


- (void) dealloc
{
	[super dealloc];
}

@end

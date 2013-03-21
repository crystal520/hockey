//
//  const.h
//  hokey5
//
//  Created by Fedor on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

#define PLAYERS_COUNT			2    // player object count

#define PHYSOBJ_COUNT			1   //physical object count
	
#define BORDER_RECT_COUNT		3 

#define UN_BORDER_RECT_COUNT            2 

#define UN_BORDER_POINTX		100.0

#define BORDER_SIZE                     13.6

#define BORDER_CORNER                   3.0

#define PLAYER_SPEED_COEFF		10.0

#define COLLISION_COEFF			0.5

#define SP_NAME_GAMEFIELD		@"gamefieldv2-ipad.png"
#define SP_NAME_KLUSHKA1		@"klushka2-ipad.png"
#define SP_NAME_KLUSHKA2		@"klushka2-ipad.png"
#define SP_NAME_SHAIBA			@"shaiba2-ipad.png"

#define TEX_LABEL_LAST                  0
#define TEX_LABEL_MAX                   1
#define TEX_GAMEFIELD                   2
#define TEX_SHAIBA                      3
#define TEX_KLUSHKA1                    4
#define TEX_KLUSHKA2                    5




#define NO_BODY_AT_POINT		-1

#define PLAYER_1_AT_POINT		0

#define PLAYER_2_AT_POINT		1

#define PLAYER_1_BORDER			1

#define PLAYER_2_BORDER			2

#define PLAYER_1                        0

#define PLAYER_2                        1

#define GOAL_STATE_NOBODY		0

#define GOAL_STATE_PLAYER2		-1

#define GOAL_STATE_PLAYER1		1

#define CONTACT_COUNT			4

#define CONTACT_UP                      0

#define CONTACT_DOWN			1

#define CONTACT_RIGHT			2

#define CONTACT_LEFT			3


typedef enum{
    restartAlert,
    resultAlert,
    resultNothing
    }alert_type;

typedef enum{
    engine_my_phys,
    engine_box2d
}game_engine;





//
//  globalOptions.h
//  hokey5
//
//  Created by Fedor on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "const.h"
@interface globalOptions : NSObject
{
    @private
    float		m_timer_count;
    int		m_player1;
    int		m_player2;
    NSArray     *m_score_table;
    CGFloat     m_friction;
    CGFloat     m_scale;
    CGPoint     m_scalexy;
    CGSize      m_screen;
    
    int		m_maxresult_int;
    int		m_lastresult_int;
    NSString	*m_maxresult_name;
    NSString	*m_lastresult_name;
    
    CGFloat     m_player_radius;
        
    NSString    *m_texture_names[6];  /* 0 label last result
                                         1 label max  result 
                                         2 gamefield
                                         3 shaiba
                                         4 klushka1
                                         5 klushka2
                                       
                                       */
    game_engine m_game;
    
}


+ (globalOptions*) sharedInstance;


- (void)		findLast;
- (void)		findMax;

- (int)			getMaxResultInt;
- (int)			getLastResultInt;

- (NSString*)           getMaxResultName;
- (NSString*)           getLastResultName;


- (NSArray*)            getScore;
- (void)		loadScore;
- (void)		saveScore;
- (void)		addScore:(id) st;

- (void)		setTimer:(float) tm;
- (float)		getTimer;

- (void)		setPlayer1:(int) pl;
- (int)			getPlayer1;
- (void)		setPlayer2:(int) pl;
- (int)			getPlayer2;
- (void)		setFriction:(CGFloat) fr;
- (CGFloat)		getFriction;
- (void)		setScale:(CGFloat) sc;
- (CGFloat)		getScale;

- (void)		setScaleX:(CGFloat) sc;
- (CGFloat)		getScaleX;
- (void)		setScaleY:(CGFloat) sc;
- (CGFloat)		getScaleY;

- (void)		setScreen:(CGSize) sc;
- (CGSize)		getScreen;


- (void)		setRadius:(CGFloat) rad;
- (CGFloat)		getRadius;

- (void)                setGameEngine:(game_engine) gt;
- (game_engine)         getGameEngine;

// texture for  devices


- (void) setIphoneTexture;
- (void) setIphoneTextureHD;
- (void) setIpadTexture;
- (void) setIpadTextureHD;

- (NSString*) getTextureName:(int) num;


@end

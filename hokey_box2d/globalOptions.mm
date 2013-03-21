//
//  globalOptions.m
//  hokey5
//
//  Created by Fedor on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "globalOptions.h"

@implementation globalOptions



// begin singletone class constructor/destructor  block
static globalOptions *m_gloabalOptions = nil;


+ (globalOptions*) sharedInstance
{
	@synchronized(self) 
	{
		if (m_gloabalOptions == nil)
		{
			m_gloabalOptions = [[self alloc] init];
		}
	}
    
 return m_gloabalOptions;
    
}

+ (id)allocWithZone:(NSZone *)zone
 
{
	 @synchronized(self) 
	{

		if (m_gloabalOptions == nil) 
		{
			 m_gloabalOptions = [super allocWithZone:zone];
			 return m_gloabalOptions;  
		}
	}
 
 return nil; //on subsequent allocation attempts return nil
}
 
- (id)copyWithZone:(NSZone *)zone
{
 return self;
}
 
- (id)retain
{
 return self;
}
 
- (unsigned)retainCount
{
 return UINT_MAX;  //denotes an object that cannot be released
}
 
- (oneway void)release
{
 //do nothing
}
 
- (id)autorelease
{
 return self;
}

//end singletone class constructor/destructor block

- (void) findLast
{
	int k = 0;
	int pl = 0;
	NSString *ttemp = @"empty";
	
	NSString *str = [m_score_table objectAtIndex:0];
	NSError* error = nil;
	NSRegularExpression* regex = 
                    [NSRegularExpression 
                            regularExpressionWithPattern	:@"([0-9]+)" 
                                                    options	:0 
                                                    error	:&error];

	NSArray* matches = 
                    [regex matchesInString	:str 
                                        options	:0 
                                        range	:NSMakeRange(0, [str length])];
	int j = 0;
	
	for (NSTextCheckingResult* match in matches)
	{
		NSString* matchText = [str substringWithRange:[match range]];
		
		if (j==0)
		{
			pl = [matchText intValue];
		}	
		
		if (j==1)
		{
			if (k < [matchText intValue])
			{
				k = [matchText intValue];
				ttemp = [NSString 
                                            stringWithFormat:@"Player%d",
                                                                    pl];
			}
		}
		
		j++;
	}
	m_lastresult_name = [[NSString alloc] initWithString:ttemp];
	m_lastresult_int = k;
}

- (void) findMax
{
	int k = 0;
	int pl = 0;
	NSString *ttemp = @"empty";
	
	for (int i=0;i<[m_score_table count];i++)
	{
		NSString *str = [m_score_table objectAtIndex:i];
		NSError* error = nil;
		NSRegularExpression* regex = 
                            [NSRegularExpression 
                                regularExpressionWithPattern	:@"([0-9]+)" 
                                                        options	:0 
                                                        error	:&error];

		NSArray* matches = 
                        [regex
                            matchesInString :str 
                                    options :0 
                                    range   :NSMakeRange(0, [str length])];
		int j = 0;
		
		for (NSTextCheckingResult* match in matches)
		{
			NSString* matchText =
                                    [str substringWithRange:[match range]];
			
			if (j==0)
			{
				pl = [matchText intValue];
			}	
			
			if (j==1)
			{
				if (k < [matchText intValue])
				{
                                    k = [matchText intValue];
                                    ttemp = [NSString 
                                                stringWithFormat:@"Player%d",
                                                                        pl];
				}
			}
			
			j++;
		}
	}
	
	
	m_maxresult_name = [[NSString alloc] initWithString:ttemp];
	m_maxresult_int = k;

}



- (int) getMaxResultInt
{
	return m_maxresult_int;
}

- (int) getLastResultInt
{
	return m_lastresult_int;
}

- (NSString*) getMaxResultName
{
	return m_maxresult_name;
}
- (NSString*) getLastResultName
{
	return m_lastresult_name;
}

- (NSArray*) getScore
{
	return m_score_table;
}


- (void) loadScore
{
	NSArray *paths =
            NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask,YES);
    
	NSString *documentsPath = [paths objectAtIndex:0];
    
	NSString *path =
                [documentsPath stringByAppendingPathComponent:@"record.txt"];
    
	NSFileManager *tmp = [NSFileManager defaultManager];
	
	if ([tmp fileExistsAtPath: path] == YES)
	{
        NSLog (@"File exists");
		m_score_table = [[NSArray alloc] initWithContentsOfFile:path];
	}
	else
	{	
		NSMutableArray *tmpmarr = [[NSMutableArray alloc] init];
		for (int i = 0;i < 12;i++)
		{
			[tmpmarr addObject:@"empty"];
		}
		m_score_table = [tmpmarr copy];
		[tmpmarr dealloc];
		[m_score_table writeToFile:path atomically:YES];
        NSLog (@"File not found");
	}	
	
}

- (void) saveScore
{	
	NSArray *paths =
            NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask,YES);
    
	NSString *documentsPath = [paths objectAtIndex:0];
	NSString *path =
                [documentsPath stringByAppendingPathComponent:@"record.txt"];
    
	NSFileManager *tmp = [NSFileManager defaultManager];
	[tmp removeItemAtPath:path error:NULL];
	[m_score_table writeToFile:path atomically:YES];
}

- (void) addScore:(id) st
{	
	NSMutableArray *tmp = [[NSMutableArray alloc] init];	
	tmp = [m_score_table mutableCopy];
	
	if ([tmp count] == 0) 
	{
		[tmp addObject	:[NSString stringWithFormat:@"%@",
                                                            st]];
	}
	
	else 
	{
		if ([tmp count] == 12)
		{
			[tmp removeLastObject];
		}
	
		[tmp insertObject   :[NSString stringWithFormat:@"%@",
                                                                st] 
                        atIndex     :0];
	}
        
        UIAlertView *temp = [[UIAlertView alloc]
                                initWithTitle   :@"Result"
                                        message :st
                                    delegate    :self
                             cancelButtonTitle  :@"Ok"
                             otherButtonTitles  :nil];
        [temp setTag:resultAlert];
        [temp show];
        [temp release];
    
	m_score_table = [tmp copy];
	
	[tmp dealloc];
}


- (void) setTimer:(float) tm
{
	m_timer_count = tm;
}

- (float) getTimer
{
	return m_timer_count;
}

- (void) setPlayer1:(int) pl
{
	m_player1 = pl;
}

- (int) getPlayer1
{
	return  m_player1;
}

- (void) setPlayer2:(int) pl
{
	m_player2 = pl;
}

- (int) getPlayer2
{
	return m_player2;
}
- (void) setFriction:(CGFloat) fr
{
	m_friction = fr;
}


- (CGFloat) getFriction
{
	return  m_friction;
}

- (void) setScale:(CGFloat) sc
{
	m_scale = sc;
}

- (CGFloat) getScale
{
	return m_scale;
}

- (void) setScaleX:(CGFloat) sc
{
	m_scalexy.x = sc;
}

- (CGFloat) getScaleX
{
	return m_scalexy.x;
}

- (void) setScaleY:(CGFloat) sc
{
	m_scalexy.y = sc;
}

- (CGFloat) getScaleY
{
	return m_scalexy.y;
}

- (void) setScreen:(CGSize) sc;
{
	m_screen = sc;
}

- (CGSize) getScreen
{
	return m_screen;
}


- (void) setRadius:(CGFloat) rad
{
	m_player_radius = rad;
}

- (CGFloat) getRadius
{
	return m_player_radius;
}

- (void)                setGameEngine:(game_engine) gt
{
    m_game = gt;
}

- (game_engine)         getGameEngine
{
    return m_game;
}



- (void) setIphoneTexture
{
    m_texture_names[TEX_LABEL_LAST] = @"label-iphone.png";          //ready
    m_texture_names[TEX_LABEL_MAX]  = @"label-iphone.png";          //ready
    m_texture_names[TEX_GAMEFIELD]  = @"gamefield-iphone.png";      //ready
    m_texture_names[TEX_SHAIBA]     = @"shaiba-iphone.png";         //ready
    m_texture_names[TEX_KLUSHKA1]   = @"klushka-iphone.png";        //ready
    m_texture_names[TEX_KLUSHKA2]   = @"klushka-iphone.png";        //ready
    
}

- (void) setIphoneTextureHD
{
    m_texture_names[TEX_LABEL_LAST] = @"label-iphonehd.png";
    m_texture_names[TEX_LABEL_MAX] = @"label-iphonehd.png";
    m_texture_names[TEX_GAMEFIELD] = @"gamefield-iphonehd.png";
    m_texture_names[TEX_SHAIBA] = @"shaiba-iphonehd.png";
    m_texture_names[TEX_KLUSHKA1] = @"klushka-iphonehd.png";
    m_texture_names[TEX_KLUSHKA2] = @"klushka-iphonehd.png";
    
}
- (void) setIpadTexture
{
    m_texture_names[TEX_LABEL_LAST] = @"label-ipad.png";            //ready
    m_texture_names[TEX_LABEL_MAX]  = @"label-ipad.png";            //ready
    m_texture_names[TEX_GAMEFIELD]  = @"gamefield-ipad.png";        //ready
    m_texture_names[TEX_SHAIBA]     = @"shaiba-ipad.png";           //ready
    m_texture_names[TEX_KLUSHKA1]   = @"klushka-ipad.png";          //ready
    m_texture_names[TEX_KLUSHKA2]   = @"klushka-ipad.png";          //ready
}

- (void) setIpadTextureHD
{
    m_texture_names[TEX_LABEL_LAST] = @"label-ipadhd.png";          //ready
    m_texture_names[TEX_LABEL_MAX]  = @"label-ipadhd.png";          //ready
    m_texture_names[TEX_GAMEFIELD]  = @"gamefield-ipadhd.png";      //ready
    m_texture_names[TEX_SHAIBA]     = @"shaiba-ipadhd.png";         //ready
    m_texture_names[TEX_KLUSHKA1]   = @"klushka-ipadhd.png";        //ready
    m_texture_names[TEX_KLUSHKA2]   = @"klushka-ipadhd.png";        //ready
    
    
}


- (NSString*) getTextureName:(int) num
{
    return m_texture_names[num];
}


@end

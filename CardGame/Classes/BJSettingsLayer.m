//
//  typeGameBJLayer.m
//  optionsBJ
//
//  Created by Acquamedia on 05/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

// Import the interfaces
#import "BJSettingsLayer.h"

// typeGameBJ implementation
@implementation BJSettingsLayer

@synthesize isShowing;

// on "init" you need to initialize your instance
-(id) init
{
	
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		self.isShowing = NO;
		
		//Añado el fondo
		background = [[CCSprite alloc] initWithFile:@"BJConfig.png"];
		[background setAnchorPoint:ccp(0.5, 0)];
		background.position = ccp(s.width/2, -background.contentSize.height);
		[self addChild:background z:1];
		
		
		NSString *tit_op1 = NSLocalizedString (@"menu_op_bj_european",@"european");
		NSString *tit_op2 = NSLocalizedString (@"menu_op_bj_american",@"american");
		NSString *tit_op3 = NSLocalizedString (@"menu_op_bj_custom",@"custom");
		NSString *tit_op4 = NSLocalizedString (@"menu_op_bj_numDeck",@"numDeck");
		NSString *tit_Op5 = NSLocalizedString (@"menu_op_bj_table",@"table");
		
		//NSString *titOp1 = NSLocalizedString (@"menu_op_bj_fall",@"fall");
		NSString *titOp2 = NSLocalizedString (@"menu_op_bj_double",@"double");
		//NSString *titOp3 = NSLocalizedString (@"menu_op_bj_split",@"split");
		
		NSString *cust_op1 = NSLocalizedString (@"menu_op_bj_yes",@"yes");
		NSString *cust_op2 = NSLocalizedString (@"menu_op_bj_no",@"no");
		
		NSString *volver = NSLocalizedString (@"menu_op_bj_back",@"volver");

		option1 = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeOption:) items:[CCMenuItemFont itemFromString:tit_op1],[CCMenuItemFont itemFromString:tit_op2],[CCMenuItemFont itemFromString:tit_op3],nil]; //European, american and custom
		
		CCMenuItemFont *title1= [CCMenuItemFont itemFromString:tit_op4]; //Baraja
		CCMenuItemFont *title2 = [CCMenuItemFont itemFromString:tit_Op5]; //Mesa
		
		//CCMenuItemFont *title3 = [CCMenuItemFont itemFromString:titOp1]; //Fall
		CCMenuItemFont *title4 = [CCMenuItemFont itemFromString:titOp2]; //Double
		//CCMenuItemFont *title5 = [CCMenuItemFont itemFromString:titOp3]; //split
	
		CCMenuItemToggle *option2 = [CCMenuItemToggle itemWithTarget:self selector:@selector(selectNumDeck:) items:[CCMenuItemFont itemFromString:[NSString stringWithFormat:@"%d",1]],[CCMenuItemFont itemFromString:[NSString stringWithFormat:@"%d",2]],[CCMenuItemFont itemFromString:[NSString stringWithFormat:@"%d",4]],[CCMenuItemFont itemFromString:[NSString stringWithFormat:@"%d",6]],[CCMenuItemFont itemFromString:[NSString stringWithFormat:@"%d",8]],nil]; //Deck number
		
		CCMenuItemToggle *option3 = [CCMenuItemToggle itemWithTarget:self selector:@selector(selectNumTable:) items:[CCMenuItemFont itemFromString:[NSString stringWithFormat:@"%d",1]],[CCMenuItemFont itemFromString:[NSString stringWithFormat:@"%d",2]],[CCMenuItemFont itemFromString:[NSString stringWithFormat:@"%d",3]],[CCMenuItemFont itemFromString:[NSString stringWithFormat:@"%d",4]],nil]; //Table number
		
		//customOp1 = [CCMenuItemToggle itemWithTarget:self selector:@selector(Fall:) items:[CCMenuItemFont itemFromString:cust_op1],[CCMenuItemFont itemFromString:cust_op2],nil]; //Fall
		customOp2 = [CCMenuItemToggle itemWithTarget:self selector:@selector(Double:) items:[CCMenuItemFont itemFromString:cust_op1],[CCMenuItemFont itemFromString:cust_op2],nil]; //Double
		//customOp3 = [CCMenuItemToggle itemWithTarget:self selector:@selector(Split:) items:[CCMenuItemFont itemFromString:cust_op1],[CCMenuItemFont itemFromString:cust_op2],nil]; //Split
		
		CCMenuItemFont *back = [CCMenuItemFont itemFromString:volver target:self selector:@selector(hideSettings)]; //Boton atras

		menu = [CCMenu menuWithItems:option1,title1,option2,title2,option3,/*title3,customOp1,*/title4,customOp2/*,title5,customOp3*/,back,nil];
		[menu alignItemsInColumns:[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],/*[NSNumber numberWithInt:2],*/[NSNumber numberWithInt:2],/*[NSNumber numberWithInt:2],*/[NSNumber numberWithInt:1],nil];
		
		set= [BlackJackSettings sharedSettings];
		//Por defecto
		int fall = set.opFall ? 0: 1;
		int doub = set.opDouble ? 0: 1;
		int split = set.opSplit ? 0: 1; 
		customOp1.selectedIndex = fall;
		customOp2.selectedIndex = doub;
		customOp3.selectedIndex = split;
		
		if ((fall == 0) && (doub == 0) && (split ==1)){
			option1.selectedIndex = 0; //European
		}else if ((fall == 0) && (doub == 1) && (split ==1)){
			option1.selectedIndex = 1;//American
		}else {
			option1.selectedIndex = 2; //Custom
		}
		//Deck number
		if (set.opDeck== 1){
			option2.selectedIndex = 0;
		}else if (set.opDeck== 2){
			option2.selectedIndex = 1;
		}else if (set.opDeck== 4){
			option2.selectedIndex = 2;
		}else if (set.opDeck== 6){
			option2.selectedIndex = 3;
		}else if (set.opDeck == 8){
			option2.selectedIndex = 4;
		}
		//Table number
		option3.selectedIndex = set.opTable -1;
				
		menu.opacity = 0.0;
		[self addChild: menu z:99];
		
	}
	return self;
}

-(void) showSettings{
	
	CCAction *action1 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, background.contentSize.height)];
	CCAction *action2 = [CCFadeIn actionWithDuration:0.2];
	
	//Animo el fondo
	[background runAction:action1];

	//Animo el menu
	[menu runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],
					 action2,
					 nil]];
	
	self.isShowing = YES;
	
}

-(void)hideSettings{
	
	[set saveSettings];
	
	CCAction *action1 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, -background.contentSize.height)];
	CCAction *action2 = [CCFadeOut actionWithDuration:0.2];
	
	//Oculto el fondo
	[menu runAction:action2];
	
	//Oculto las opciones
	[background runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2],
					 action1,
					 nil]];
	
	self.isShowing=NO;
}

-(void) changeOption: (id) sender{
	if (option1.selectedIndex == 0){ //European
		set.opFall = YES;
		set.opDouble = YES;
		set.opSplit = NO;
	}else if (option1.selectedIndex == 1){ //American
		set.opFall = YES;
		set.opDouble = NO;
		set.opSplit = NO;
	}
	[set saveSettings];
	int fall = set.opFall ? 0: 1;
	int doub = set.opDouble ? 0: 1;
	int split = set.opSplit ? 0: 1; 
	customOp1.selectedIndex = fall;
	customOp2.selectedIndex = doub;
	customOp3.selectedIndex = split;
}

-(void) selectNumDeck: (id) sender{
	if ([sender selectedIndex] == 0){
		set.opDeck = 1;
	}else if ([sender selectedIndex] == 1){
		set.opDeck = 2;
	}else if ([sender selectedIndex] == 2){
		set.opDeck = 4;
	}else if ([sender selectedIndex] == 3){
		set.opDeck = 6;
	}else {
		set.opDeck = 8;
	}
	[set saveSettings];
}	
-(void) selectNumTable: (id) sender{
	set.opTable = [sender selectedIndex]+1;
	[set saveSettings];
}

-(void) Fall: (id) sender{
	if ([sender selectedIndex] == 0){
		set.opFall = YES;
	}else {
		set.opFall = NO;
	}
	//Cambiar vista de opciones
	int fall = set.opFall ? 0: 1;
	int doub = set.opDouble ? 0: 1;
	int split = set.opSplit ? 0: 1; 
	
	if ((fall == 0) && (doub == 0) && (split ==1)){
		option1.selectedIndex = 0; //European
	}else if ((fall == 0) && (doub == 1) && (split ==1)){
		option1.selectedIndex = 1;//American
	}else {
		option1.selectedIndex = 2; //Custom
	}

	
}
-(void) Double: (id) sender{
	if ([sender selectedIndex] == 0){
		set.opDouble = YES;
	}else {
		set.opDouble = NO;
	}
	//Cambiar vista de opciones
	int fall = set.opFall ? 0: 1;
	int doub = set.opDouble ? 0: 1;
	int split = set.opSplit ? 0: 1; 
	
	if ((fall == 0) && (doub == 0) && (split ==1)){
		option1.selectedIndex = 0; //European
	}else if ((fall == 0) && (doub == 1) && (split ==1)){
		option1.selectedIndex = 1;//American
	}else {
		option1.selectedIndex = 2; //Custom
	}
}
-(void) Split: (id) sender{
	if ([sender selectedIndex] == 0){
		set.opSplit = YES;
	}else {
		set.opSplit = NO;
	}
	//Cambiar vista de opciones
	int fall = set.opFall ? 0: 1;
	int doub = set.opDouble ? 0: 1;
	int split = set.opSplit ? 0: 1; 
	
	if ((fall == 0) && (doub == 0) && (split ==1)){
		option1.selectedIndex = 0; //European
	}else if ((fall == 0) && (doub == 1) && (split ==1)){
		option1.selectedIndex = 1;//American
	}else {
		option1.selectedIndex = 2; //Custom
	}
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
}
@end

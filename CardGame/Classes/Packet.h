//
//  Packet.h
//  CardGame
//
//  Created by ender on 11/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PacketTypeVoice = 0,
    PacketTypeStart = 1,
    PacketTypeBet = 2,
    PacketTypeStand = 3,
    PacketTypeGotCard = 4,
    PacketTypeDealerTurns = 5,
	PacketTypePosition = 6,
	PacketTypePaint = 7,
	PacketTypeReadyForPositions = 8,
	PacketTypeReadyQuestion = 9,
	PacketTypeYes=10,
	PacketTypeNo =11,
	PacketTypeResult= 12,
	PacketTypeYourTurn = 13,
	PacketTypeDealerDone = 14,
	PacketTypeDouble = 15,
	PacketTypeReady = 16,
	PacketTypeExit = 17
	
} PacketType;


typedef enum {
    PaloPica,
	PaloDiamante,
	PaloTrebol,
	paloCorazon
} CardPalo;

typedef struct{ 
	
	
	
	PacketType type;
	int bet;
	int puntuation;
	PositionInTable position;
	int targetHash;
	PlayerResult result;

	
	 
} Packet;


typedef struct{ 
	
	
	
	PacketType type;
	int targetHash;
	int cardNumber;
	CardPalo cardPalo;
	
	
	
} CardPacket;





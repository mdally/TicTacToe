//
//  ViewController.h
//  Dally_lab3
//
//  Created by Labuser on 2/23/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardSquare.h"
#import "HashMarks.h"

@interface ViewController : UIViewController {
    IBOutlet UIImageView* backgroundImage;
    IBOutlet UIImageView* boardImage;
    
    IBOutlet UILabel* playerTurn;
    
    IBOutlet UIButton* playButton;
    IBOutlet UIImageView* playButtonBackground;
    
    IBOutlet BoardSquare* space00;
    IBOutlet BoardSquare* space01;
    IBOutlet BoardSquare* space02;
    
    IBOutlet BoardSquare* space10;
    IBOutlet BoardSquare* space11;
    IBOutlet BoardSquare* space12;
    
    IBOutlet BoardSquare* space20;
    IBOutlet BoardSquare* space21;
    IBOutlet BoardSquare* space22;
    
    IBOutlet HashMarks* hashMarks;
    
    NSInteger currentPlayer;
    BOOL gameHasWinner;
    int winner;
    
    NSArray* board;
    Token playerToken[2];
    NSString* playerName[2];
    BOOL usingAI;
    BOOL acceptingInput;
    int tokensPlaced;
}

- (void) homeScreen;

- (BOOL) gameWon;

- (void) endGame;

- (void) changePlayer;

- (void) newGame;

- (void) newGamePhase2;

- (void) newGamePhase3;

- (void) AIMove;

- (BOOL) canWinWithPlayer:(Token)tok Row:(int)row Column:(int)col;

- (BOOL) hasAdjacentPieceAtRow:(int)row Column:(int)col;

+ (void) shuffleArray:(NSMutableArray*)arr;

@end
//
//  ViewController.m
//  Dally_lab3
//
//  Created by Labuser on 2/23/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //make the board border a little fancier
    boardImage.layer.cornerRadius = boardImage.frame.size.width / 2;
    boardImage.clipsToBounds = YES;
    boardImage.layer.borderWidth = 3.0f;
    boardImage.layer.borderColor = [UIColor whiteColor].CGColor;
    boardImage.layer.cornerRadius = 10.0f;
    
    playButtonBackground.layer.cornerRadius = boardImage.frame.size.width / 2;
    playButtonBackground.clipsToBounds = YES;
    playButtonBackground.layer.borderWidth = 3.0f;
    playButtonBackground.layer.borderColor = [UIColor whiteColor].CGColor;
    playButtonBackground.layer.cornerRadius = 10.0f;
    
    board = [NSArray arrayWithObjects:
                [NSArray arrayWithObjects:space00, space01, space02, nil],
                [NSArray arrayWithObjects:space10, space11, space12, nil],
                [NSArray arrayWithObjects:space20, space21, space22, nil],
                nil
            ];

    playerName[0] = @"Player One";
    playerName[1] = @"Player Two";
}

- (void)viewDidAppear:(BOOL)animated{
    [self homeScreen];
}

- (void)homeScreen{
    playButtonBackground.hidden = NO;
    playButton.hidden = NO;
}

- (IBAction)playButtonPressed:(id)sender {
    playButton.hidden = YES;
    playButtonBackground.hidden = YES;
    
    [self newGame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gameWon{
    BoardSquare* sq0;
    BoardSquare* sq1;
    BoardSquare* sq2;
    
    for(int i = 0; i < 3; ++i){
        //rows
        sq0 = [[board objectAtIndex:i] objectAtIndex:0];
        sq1 = [[board objectAtIndex:i] objectAtIndex:1];
        sq2 = [[board objectAtIndex:i] objectAtIndex:2];
        if(sq0.token == sq1.token && sq0.token == sq2.token && sq0.token != Empty){
            gameHasWinner = YES;
            winner = (sq0.token == playerToken[0]) ? 0 : 1;
            return YES;
        }
        
        //cols
        sq0 = [[board objectAtIndex:0] objectAtIndex:i];
        sq1 = [[board objectAtIndex:1] objectAtIndex:i];
        sq2 = [[board objectAtIndex:2] objectAtIndex:i];
        if(sq0.token == sq1.token && sq0.token == sq2.token && sq0.token != Empty){
            gameHasWinner = YES;
            winner = (sq0.token == playerToken[0]) ? 0 : 1;
            return YES;
        }
    }
    
    //diags
    sq0 = [[board objectAtIndex:0] objectAtIndex:0];
    sq1 = [[board objectAtIndex:1] objectAtIndex:1];
    sq2 = [[board objectAtIndex:2] objectAtIndex:2];
    if(sq0.token == sq1.token && sq0.token == sq2.token && sq0.token != Empty){
        gameHasWinner = YES;
        winner = (sq0.token == playerToken[0]) ? 0 : 1;
        return YES;
    }
    
    sq0 = [[board objectAtIndex:2] objectAtIndex:0];
    sq1 = [[board objectAtIndex:1] objectAtIndex:1];
    sq2 = [[board objectAtIndex:0] objectAtIndex:2];
    if(sq0.token == sq1.token && sq0.token == sq2.token && sq0.token != Empty){
        gameHasWinner = YES;
        winner = (sq0.token == playerToken[0]) ? 0 : 1;
        return YES;
    }
    
    gameHasWinner = NO;
    return NO;
}

- (void)newGame{
    //initialize the board
    for(int i = 0; i < 3; ++i){
        for(int j = 0; j < 3; ++j){
            BoardSquare* sq = [[board objectAtIndex:i] objectAtIndex:j];
            
            [sq changeToken:Empty];
        }
    }
    tokensPlaced = 0;
    
    //1 or 2 players?
    UIAlertController* numPlayers = [UIAlertController
                                     alertControllerWithTitle:@"How many players?"
                                     message:@""
                                     preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* one = [UIAlertAction
                          actionWithTitle:@"One"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction* action){
                              usingAI = YES;
                              [self newGamePhase2];
                          }];
    UIAlertAction* two = [UIAlertAction
                          actionWithTitle:@"Two"
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction* action){
                              usingAI = NO;
                              [self newGamePhase2];
                          }];
    [numPlayers addAction:one];
    [numPlayers addAction:two];
    
    [self presentViewController:numPlayers animated:YES completion:nil];
}

- (void) newGamePhase2{
    //who goes first?
    UIAlertController* whoFirst = [UIAlertController
                                   alertControllerWithTitle:@"Who will go first?"
                                   message:@""
                                   preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* p1 = [UIAlertAction
                         actionWithTitle:@"Player One"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction* action){
                             currentPlayer = 0;
                             [self newGamePhase3];
                         }];
    UIAlertAction* p2 = [UIAlertAction
                         actionWithTitle:@"Player Two"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction* action){
                             currentPlayer = 1;
                             [self newGamePhase3];
                         }];
    UIAlertAction* rand = [UIAlertAction
                           actionWithTitle:@"Random"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction* action){
                               currentPlayer = arc4random_uniform(2);
                               [self newGamePhase3];
                           }];
    [whoFirst addAction:p1];
    [whoFirst addAction:p2];
    [whoFirst addAction:rand];
    
    [self presentViewController:whoFirst animated:YES completion:nil];
}

- (void) newGamePhase3{
    //update the turn label
    [playerTurn setText:[playerName[currentPlayer] stringByAppendingString:@"'s Turn"]];
    [hashMarks jitter];
    boardImage.hidden = NO;
    playerTurn.hidden = NO;
    hashMarks.hidden = NO;
    for(int i = 0; i < 3; ++i){
        for(int j = 0; j < 3; ++j){
            BoardSquare* sq = [[board objectAtIndex:i] objectAtIndex:j];
            sq.hidden = NO;
        }
    }
    
    //randomize the player tokens
    int tmp = arc4random_uniform(2);
    if(tmp == 0){
        playerToken[0] = X;
        playerToken[1] = O;
    }
    else{
        playerToken[0] = O;
        playerToken[1] = X;
    }
    
    if(usingAI && currentPlayer == 1){
        [self AIMove];
    }
    acceptingInput = YES;
}

- (void)endGame{
    //hide game elements
    playerTurn.hidden = YES;
    hashMarks.hidden = YES;
    for(int i = 0; i < 3; ++i){
        for(int j = 0; j < 3; ++j){
            BoardSquare* sq = [[board objectAtIndex:i] objectAtIndex:j];
            sq.hidden = YES;
        }
    }
    boardImage.hidden = YES;
    
    NSString* topText = @"Cat's Game!";
    if(gameHasWinner){
        topText = [playerName[winner] stringByAppendingString:@" has won!"];
    }
    
    //prompt for new game
    UIAlertController* newGame = [UIAlertController
                                  alertControllerWithTitle:topText
                                  message:@"Play Again?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    //if new game, reset the board, start again
    UIAlertAction* sure = [UIAlertAction
                           actionWithTitle:@"Sure!"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction* action){
                               [newGame dismissViewControllerAnimated:YES completion:nil];
                               [self newGame];
                           }];
    
    //if no new game, quit
    UIAlertAction* noThanks = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction* action){
                                   [newGame dismissViewControllerAnimated:YES completion:nil];
                                   [self homeScreen];
                               }];
    
    [newGame addAction:sure];
    [newGame addAction:noThanks];
    
    [self presentViewController:newGame animated:YES completion:nil];
}

- (void)changePlayer{
    if(currentPlayer == 0) currentPlayer = 1;
    else currentPlayer = 0;
    
    //update the label
    [playerTurn setText:[playerName[currentPlayer] stringByAppendingString:@"'s Turn"]];
}

- (IBAction)boardSquarePressed:(id)sender {
    if(acceptingInput){
        acceptingInput = NO;
        BoardSquare* sq = (BoardSquare*)sender;
        
        //check if valid move, protest if not
        if(sq.token != Empty){
            UIAlertController* invalidMove = [UIAlertController
                                              alertControllerWithTitle:@"Oops!"
                                              message:@"Not a valid move."
                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [invalidMove dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            
            [invalidMove addAction:ok];
            
            [self presentViewController:invalidMove animated:YES completion:nil];
        }
        //otherwise, update game state
        else{
            [sq changeToken:playerToken[currentPlayer]];
            ++tokensPlaced;
         
            //check if won
            if([self gameWon] || tokensPlaced == 9){
                [self endGame];
            }
            else{
                //if not, switch player num and label
                [self changePlayer];
                
                //take computer move if necessary
                if(usingAI){
                    [self AIMove];
                    
                    if([self gameWon] || tokensPlaced == 9){
                        [self endGame];
                    }
                }
            }
            
            //jitter/recolor the tokens and hash marks
            [hashMarks jitter];
            for(int i = 0; i < 3; ++i){
                for(int j = 0; j < 3; ++j){
                    BoardSquare* sq = [[board objectAtIndex:i] objectAtIndex:j];
                    [sq jitter];
                }
            }
        }
        
        acceptingInput = YES;
    }
}

- (void)AIMove{
    //[NSThread sleepForTimeInterval:1.5];
    
    int otherPlayer = 0;
    if(currentPlayer == 0) otherPlayer = 1;
    
    BoardSquare* sq;
    
    //win if possible
    for(int i = 0; i < 3; ++i){
        for(int j = 0; j < 3; ++j){
            sq = [[board objectAtIndex:i] objectAtIndex:j];
            if(sq.token == Empty && [self canWinWithPlayer:playerToken[currentPlayer] Row:i Column:j]){
                [sq changeToken:playerToken[currentPlayer]];
                ++tokensPlaced;
                [self changePlayer];
                return;
            }
        }
    }
    
    //block player win
    for(int i = 0; i < 3; ++i){
        for(int j = 0; j < 3; ++j){
            sq = [[board objectAtIndex:i] objectAtIndex:j];
            if(sq.token == Empty && [self canWinWithPlayer:playerToken[otherPlayer] Row:i Column:j]){
                [sq changeToken:playerToken[currentPlayer]];
                ++tokensPlaced;
                [self changePlayer];
                return;
            }
        }
    }
    
    //standard move
    if(tokensPlaced == 0){
        sq = [[board objectAtIndex:1] objectAtIndex:1];
        [sq changeToken:playerToken[currentPlayer]];
        ++tokensPlaced;
        [self changePlayer];
        return;
    }
    else{
        //try to pick a random row/col/diag with another token in it (and no enemy tokens)
        NSMutableArray* rows = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0], [NSNumber numberWithInteger:1], [NSNumber numberWithInteger:2], nil];
        NSMutableArray* cols = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0], [NSNumber numberWithInteger:1], [NSNumber numberWithInteger:2], nil];
        [ViewController shuffleArray:rows];
        [ViewController shuffleArray:cols];
        
        for(int i = 0; i < 3; ++i){
            [ViewController shuffleArray:cols];
            
            for(int j = 0; j < 3; ++j){
                int row = (int)[[rows objectAtIndex:i] integerValue];
                int col = (int)[[cols objectAtIndex:j] integerValue];
                sq = [[board objectAtIndex:row] objectAtIndex:col];
                if(sq.token == Empty && [self hasAdjacentPieceAtRow:row Column:col]){
                    [sq changeToken:playerToken[currentPlayer]];
                    ++tokensPlaced;
                    [self changePlayer];
                    return;
                }
            }
        }
        
        //otherwise, pick a random empty square
        [ViewController shuffleArray:rows];
        [ViewController shuffleArray:cols];
        
        for(int i = 0; i < 3; ++i){
            [ViewController shuffleArray:cols];
            
            for(int j = 0; j < 3; ++j){
                int row = (int)[[rows objectAtIndex:i] integerValue];
                int col = (int)[[cols objectAtIndex:j] integerValue];
                sq = [[board objectAtIndex:row] objectAtIndex:col];
                if(sq.token == Empty){
                    [sq changeToken:playerToken[currentPlayer]];
                    ++tokensPlaced;
                    [self changePlayer];
                    return;
                }
            }
        }
    }
}

- (BOOL) canWinWithPlayer:(Token)tok Row:(int)row Column:(int)col{
    //check row
    int matchingTokens = 0;
    for(int i = 0; i < 3; ++i){
        BoardSquare* sq = [[board objectAtIndex:row] objectAtIndex:i];
        if(sq.token == tok) ++matchingTokens;
    }
    if(matchingTokens == 2) return YES;
    
    //check column
    matchingTokens = 0;
    for(int i = 0; i < 3; ++i){
        BoardSquare* sq = [[board objectAtIndex:i] objectAtIndex:col];
        if(sq.token == tok) ++matchingTokens;
    }
    if(matchingTokens == 2) return YES;
    
    //check down diagonal
    BOOL inDiagonal = NO;
    matchingTokens = 0;
    for(int i = 0; i < 3; ++i){
        BoardSquare* sq = [[board objectAtIndex:2-i] objectAtIndex:i];
        if(sq.token == tok) ++matchingTokens;
        if((row == 2-i) && (col == i)) inDiagonal = YES;
    }
    if(inDiagonal && matchingTokens == 2){
        return YES;
    }
    
    //check up diagonal
    inDiagonal = NO;
    matchingTokens = 0;
    for(int i = 0; i < 3; ++i){
        BoardSquare* sq = [[board objectAtIndex:i] objectAtIndex: i];
        if(sq.token == tok) ++matchingTokens;
        if((row == i) && (col == i)) inDiagonal = YES;
    }
    if(inDiagonal && matchingTokens == 2) return YES;
    
    return NO;
}

- (BOOL) hasAdjacentPieceAtRow:(int)row Column:(int)col{
    //check row
    int matchingTokens = 0;
    int otherTokens = 0;
    for(int i = 0; i < 3; ++i){
        BoardSquare* sq = [[board objectAtIndex:row] objectAtIndex:i];
        if(sq.token == playerToken[currentPlayer]) ++matchingTokens;
        else if(sq.token != Empty) ++otherTokens;
    }
    if(matchingTokens == 1 && otherTokens == 0) return YES;
    
    //check column
    matchingTokens = 0;
    otherTokens = 0;
    for(int i = 0; i < 3; ++i){
        BoardSquare* sq = [[board objectAtIndex:i] objectAtIndex:col];
        if(sq.token == playerToken[currentPlayer]) ++matchingTokens;
        else if(sq.token != Empty) ++otherTokens;
    }
    if(matchingTokens == 1 && otherTokens == 0) return YES;
    
    //check down diagonal
    BOOL inDiagonal = NO;
    matchingTokens = 0;
    otherTokens = 0;
    for(int i = 0; i < 3; ++i){
        BoardSquare* sq = [[board objectAtIndex:2-i] objectAtIndex:i];
        if(sq.token == playerToken[currentPlayer]) ++matchingTokens;
        else if(sq.token != Empty) ++otherTokens;
        if((row == 2-i) && (col == i)) inDiagonal = YES;
    }
    if(inDiagonal && matchingTokens == 1 && otherTokens == 0) return YES;
    
    //check up diagonal
    inDiagonal = NO;
    matchingTokens = 0;
    otherTokens = 0;
    for(int i = 0; i < 3; ++i){
        BoardSquare* sq = [[board objectAtIndex:i] objectAtIndex: i];
        if(sq.token == playerToken[currentPlayer]) ++matchingTokens;
        else if(sq.token != Empty) ++otherTokens;
        if((row == i) && (col == i)) inDiagonal = YES;
    }
    if(inDiagonal && matchingTokens == 1 && otherTokens == 0) return YES;
    
    return NO;
}

+ (void) shuffleArray:(NSMutableArray *)arr{
    int count = 3;
    for (int i = 0; i < count; ++i) {
        int remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform(remainingCount);
        [arr exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
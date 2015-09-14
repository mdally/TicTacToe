//
//  BoardSquare.h
//  Dally_lab3
//
//  Created by Labuser on 2/23/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Token) { X, O, Empty };

@interface BoardSquare : UIButton

@property Token token;

@property int currentRotation;

- (void) changeToken:(Token)tok;

- (void) updateTitle:(NSString*)str;

- (void) jitter;

+ (NSString*) tokenText:(Token)tok;

@end

//
//  BoardSquare.m
//  Dally_lab3
//
//  Created by Labuser on 2/23/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import "BoardSquare.h"

@implementation BoardSquare

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) init{
    self = [super init];
    self.currentRotation = 0;
    return self;
}

- (void) updateTitle:(NSString *)str{
    [self setTitle:str forState:(UIControlStateNormal)];
}

- (void) changeToken:(Token)tok{
    self.token = tok;
    [self performSelector:@selector(updateTitle:) withObject:[BoardSquare tokenText:tok] afterDelay:(0)];
}

- (void) jitter{
    int rotationMagnitude = 30;
    int newRotation = arc4random_uniform(rotationMagnitude);
    newRotation -= rotationMagnitude/2;
    self.transform = CGAffineTransformMakeRotation(((newRotation-self.currentRotation)*M_PI )/180);
}

+ (NSString*) tokenText:(Token)tok{
    NSString* str = [NSString alloc];
    switch (tok) {
        case X:
            str = @"X";
            break;
        case O:
            str = @"O";
            break;
        default:
            str = @"";
            break;
    }
    
    return str;
}

@end

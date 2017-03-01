//
//  NSObject+OCwithCLIPS.h
//  CLPS
//
//  Created by 瀚 段 on 17/2/4.
//  Copyright © 2017年 瀚 段. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCwithCLIPS:NSObject
@property (nonatomic,strong) NSMutableArray *CharacterList;
@property (strong, nonatomic) NSString *tmpname;
- init;
-(void) test;
-(void) sendCLIPScommond:(NSString *)cmd;
-(void) generateFact;
-(void) reset;
-(void) generatetrain;
@end

//
//  NSObject+OCwithCLIPS.m
//  CLPS
//
//  Created by 瀚 段 on 17/2/4.
//  Copyright © 2017年 瀚 段. All rights reserved.
//

#import "NSObject+OCwithCLIPS.h"
#import <CLIPSiOS/clips.h>
#import "character.h"

@implementation OCwithCLIPS

NSArray *criteria;
NSDictionary *criteriaData;
void *clipsEnv;
@synthesize  tmpname,CharacterList;

- init
{
    self = [super init];
    if (!self) return nil;
    self.CharacterList=[NSMutableArray array];
    clipsEnv = CreateEnvironment();
    if (clipsEnv == NULL) return self;
    
    //NSString *filePath = [[NSBundle mainBundle] pathForResource: @"wine" ofType: @"clp"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource: @"myClips" ofType: @"clp"];
    NSLog(@"%@", filePath);
    
    char *cFilePath = (char *) [filePath UTF8String];
    EnvLoad(clipsEnv,cFilePath);
    
    
    EnvReset(clipsEnv);
    
    return self;
}

-(void) test
{


 // EnvAssertString(clipsEnv,"(characters (name lonewolf2)(certainty 75) (description description..))");
    EnvRun(clipsEnv,-1L);
    
    
    DATA_OBJECT theResult, theSlot;
    struct multifield *theMultifield;
    void *theFact;
    NSString *CharacterName;
    NSNumber *certainty;
    character *theCharacter;
    
    [CharacterList removeAllObjects];
    
        EnvEval(clipsEnv,"(SALESMAN::get-characters-list )",&theResult);
    if (GetType(theResult) != MULTIFIELD) return;
    
    theMultifield = GetValue(theResult);
    
    for (int i = 1; i <= GetDOLength(theResult); i++)
    {
        if (GetMFType(theMultifield,i) != FACT_ADDRESS) continue;
        
        theFact = GetMFValue(theMultifield,i);
        
        EnvGetFactSlot(clipsEnv,theFact,"name",&theSlot);
        
        if ((GetType(theSlot) == SYMBOL) || (GetType(theSlot) == STRING))
        { CharacterName = [NSString stringWithCString: DOToString(theSlot) encoding: NSUTF8StringEncoding]; }
        else
        { CharacterName = @"Unknown"; }
        
        EnvGetFactSlot(clipsEnv,theFact,"certainty",&theSlot);
        
        if (GetType(theSlot) == INTEGER)
        { certainty = [NSNumber numberWithInteger: DOToInteger(theSlot)]; }
        else if (GetType(theSlot) == FLOAT)
        { certainty = [NSNumber numberWithFloat: DOToFloat(theSlot)]; }
        else
        { certainty = [NSNumber numberWithInteger: 0]; }
        
        theCharacter = [[character alloc] init];
        theCharacter.name = CharacterName;
        tmpname = CharacterName;
       // NSLog(@"%@", CharacterName);
        theCharacter.certainty = certainty;
       // NSLog(@"%@", certainty );
        
        [CharacterList addObject: theCharacter];
    }

}
-(void) sendCLIPScommond:(NSString *)cmd
{
     NSLog(@"%@", cmd );
    const char *c = [cmd UTF8String];
    EnvAssertString(clipsEnv,c);
    
}
-(void)generateFact
{
    EnvRun(clipsEnv,-1L);
    
    
    DATA_OBJECT theResult, theSlot;
    struct multifield *theMultifield;
    void *theFact;
    NSString *CharacterName;
    NSNumber *certainty;
    character *theCharacter;
    
    [CharacterList removeAllObjects];
    
    EnvEval(clipsEnv,"(SALESMAN::get-characters-list )",&theResult);
    if (GetType(theResult) != MULTIFIELD) return;
    
    theMultifield = GetValue(theResult);
    
    for (int i = 1; i <= GetDOLength(theResult); i++)
    {
        if (GetMFType(theMultifield,i) != FACT_ADDRESS) continue;
        
        theFact = GetMFValue(theMultifield,i);
        
        EnvGetFactSlot(clipsEnv,theFact,"name",&theSlot);
        
        if ((GetType(theSlot) == SYMBOL) || (GetType(theSlot) == STRING))
        { CharacterName = [NSString stringWithCString: DOToString(theSlot) encoding: NSUTF8StringEncoding]; }
        else
        { CharacterName = @"Unknown"; }
        
        EnvGetFactSlot(clipsEnv,theFact,"certainty",&theSlot);
        
        if (GetType(theSlot) == INTEGER)
        { certainty = [NSNumber numberWithInteger: DOToInteger(theSlot)]; }
        else if (GetType(theSlot) == FLOAT)
        { certainty = [NSNumber numberWithFloat: DOToFloat(theSlot)]; }
        else
        { certainty = [NSNumber numberWithInteger: 0]; }
        
        theCharacter = [[character alloc] init];
        theCharacter.name = CharacterName;
        tmpname = CharacterName;
        // NSLog(@"%@", CharacterName);
        theCharacter.certainty = certainty;
        // NSLog(@"%@", certainty );
        
        [CharacterList addObject: theCharacter];
    }
}

@end

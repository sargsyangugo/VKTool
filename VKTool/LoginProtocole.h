//
//  LoginProtocole.h
//  VKTool
//
//  Created by Admin on 5/10/13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UILoginViewDelegate <NSObject>

-(void) userDidLogined:(NSMutableDictionary*) params;

@end

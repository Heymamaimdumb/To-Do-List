//
//  ViewController.h
//  ToDo List
//
//  Created by Vladislav on 02.09.15.
//  Copyright (c) 2015 Vladislav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditDateVC : UIViewController

@property  (strong, nonatomic) NSDate *dateResult;
@property   (strong, nonatomic) NSString *infoResult;
@property   (assign,nonatomic) BOOL isDetail;

@end


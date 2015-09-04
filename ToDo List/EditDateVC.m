//
//  ViewController.m
//  ToDo List
//
//  Created by Vladislav on 02.09.15.
//  Copyright (c) 2015 Vladislav. All rights reserved.
//

#import "EditDateVC.h"

@interface EditDateVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *noteText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;




@end

@implementation EditDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isDetail) {
        self.noteText.text = self.infoResult;
        self.datePicker.date = self.dateResult;
        self.noteText.userInteractionEnabled = NO;
        self.saveBtn.alpha = 0;
        self.datePicker.userInteractionEnabled = NO;
        
    }
    else{
    self.dateResult = self.datePicker.date;
    
    [self.saveBtn addTarget:self action:@selector(saveDate) forControlEvents:UIControlEventTouchUpInside];
   
    [self.datePicker addTarget:self action:@selector(dateValueChange) forControlEvents:UIControlEventValueChanged];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer   alloc]initWithTarget:self action:@selector(closeOnTap)];
    
    [self.view addGestureRecognizer:tap];
    
    self.datePicker.minimumDate = [NSDate date];
    
    self.saveBtn.userInteractionEnabled = false;
    }
}

-(void)saveDate{
    
    if(self.dateResult){
    
        if ([self.dateResult compare:[NSDate date]] == NSOrderedSame){
            
            [self ShowAlertMessage:@"Please, choose correct date of event"];
        }
    
    else if ([self.dateResult compare:[NSDate date]] == NSOrderedAscending){
        
        [self ShowAlertMessage:@"Please, choose correct date of event"];
        
        
    }
        
    else{
        
        [self SetNotification];
        
    }
    
    }
}

-(void) dateValueChange{
    
    self.dateResult = self.datePicker.date;
    
}

- (void) closeOnTap{
    if ([self.noteText.text length] !=0 ){
        [self.view endEditing:YES];
        self.saveBtn.userInteractionEnabled = true;
        
    }
    else {
        [self ShowAlertMessage:@"Please, write something about event"];
    }

    
    
    
}

-(void) SetNotification {
    
    
    NSString *resultText = self.noteText.text;
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    dateFormater.dateFormat = @"HH:mm dd.MMMM.yyyy";
    NSString *resultDateFormatted = [dateFormater stringFromDate:self.dateResult];
    
    NSDictionary *resultDict = [[NSDictionary alloc]initWithObjectsAndKeys:resultText,@"resultText",resultDateFormatted, @"resultDate", nil];
    
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.userInfo = resultDict;
    notification.timeZone  = [NSTimeZone defaultTimeZone];
    notification.fireDate = self.dateResult;
    notification.alertBody = resultText;
    notification.applicationIconBadgeNumber = 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    
    if ([self.noteText.text length] !=0 ){
        [self.noteText resignFirstResponder];
        self.saveBtn.userInteractionEnabled = true;
        return YES;
    }
    else {
        [self ShowAlertMessage:@"Please, write something about event"];
    }
    
    return NO;
}
-(void) ShowAlertMessage :(NSString*)message{

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

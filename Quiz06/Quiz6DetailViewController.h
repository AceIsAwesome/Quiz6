//
//  Quiz6DetailViewController.h
//  Quiz6
//
//  Created by Michael Vitone on 3/28/14.
//  Copyright (c) 2014 Michael Vitone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface Quiz6DetailViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *taskNameTextField;
@property (weak, nonatomic) IBOutlet UISlider *urgencySlider;
@property (weak, nonatomic) IBOutlet UILabel *urgencyLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)save:(id)sender;

- (IBAction)sliderChange:(id)sender;



@property (nonatomic, strong) Task *currentTask;

-(void) setTask:(Task *)newTask;

@property (nonatomic, copy) void (^dismissBlock)(void);

@end

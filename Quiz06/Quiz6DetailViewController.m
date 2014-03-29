//
//  Quiz6DetailViewController.m
//  Quiz6
//
//  Created by Michael Vitone on 3/28/14.
//  Copyright (c) 2014 Michael Vitone. All rights reserved.
//

#import "Quiz6DetailViewController.h"

@interface Quiz6DetailViewController ()
- (void)configureView;
@end

@implementation Quiz6DetailViewController

#pragma mark - Managing the detail item
@synthesize taskNameTextField;
@synthesize urgencySlider;
@synthesize urgencyLabel;
@synthesize datePicker;
@synthesize currentTask;

@synthesize dismissBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [taskNameTextField setDelegate:self];
}

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [self setUrgencyLabel:nil];
    [self setUrgencySlider:nil];
    [self setTaskNameTextField:nil];
    [super viewDidUnload];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [taskNameTextField resignFirstResponder];
    
    return YES;
}


- (void) viewWillAppear:(BOOL)animated
{
    [datePicker setDate:currentTask.dueDate];
    [urgencyLabel setText:[NSString stringWithFormat:@"Urgency: %.0f", currentTask.urgency]];
    [urgencySlider setValue:currentTask.urgency/10.0];
    [taskNameTextField setText:currentTask.name];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)save:(id)sender {
    
    [currentTask setDueDate:[datePicker date]];
    [currentTask setName:taskNameTextField.text];
    [currentTask setUrgency:urgencySlider.value * 10.0];
    
    [self dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (IBAction)sliderChange:(id)sender {
    
    urgencyLabel.text = [NSString stringWithFormat:@"Urgency %.0f", urgencySlider.value*10];
}

@end

//
//  AddViewController.h
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *lbltitle;
@property (weak, nonatomic) IBOutlet UITextView *lbldescription;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type;
@property Task *task2;
@property NSUserDefaults *def;
@end

NS_ASSUME_NONNULL_END




//
//  AddViewController.h
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "ViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *lbltitle;
@property (weak, nonatomic) IBOutlet UITextView *lbldescription;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *type;

@end

NS_ASSUME_NONNULL_END




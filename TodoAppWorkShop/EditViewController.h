//
//  EditViewController.h
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *lbltitle;
@property (weak, nonatomic) IBOutlet UITextView *lbldes;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritysegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Typesegment;

@end

NS_ASSUME_NONNULL_END

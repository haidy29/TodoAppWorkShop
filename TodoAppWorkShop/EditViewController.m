//
//  EditViewController.m
//  TodoAppWorkShop
//
//  Created by Sohila Ahmed on 12/08/2024.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController
{
    
}
static NSUserDefaults *def;

- (void)viewDidLoad {
    [super viewDidLoad];
    _lbltitle.text =  _edit_task.t_name;
    _lbldes.text = _edit_task.t_des;
    _datePicker.date = _edit_task.t_date;
    if([_edit_task.t_priority  isEqualToString: @"Low"]){
        self.prioritysegment.selectedSegmentIndex = 0;
    }else if([_edit_task.t_priority  isEqual: @"Medium"]){
        self.prioritysegment.selectedSegmentIndex = 1;
    }else if([_edit_task.t_priority  isEqual: @"High"]){
        self.prioritysegment.selectedSegmentIndex = 2;
    }
    def = [NSUserDefaults standardUserDefaults];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnedit:(id)sender {
    
}

@end

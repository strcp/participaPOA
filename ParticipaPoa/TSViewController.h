//
//  TSViewController.h
//  ParticipaPoa
//
//  Created by Cristiano Fernandes on 5/24/14.
//  Copyright (c) 2014 Azapp Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>
{
    IBOutlet UITableView *_tableView;
    IBOutlet UINavigationBar *_navBar;
    NSArray *_records;
}

@end

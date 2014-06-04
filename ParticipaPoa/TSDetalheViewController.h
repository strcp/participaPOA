//
//  TSDetalheViewController.h
//  ParticipaPoa
//
//  Created by Cristiano Fernandes on 6/4/14.
//  Copyright (c) 2014 Azapp Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSDetalheViewController : UIViewController
{
    IBOutlet UILabel *_tema;
    IBOutlet UILabel *_valor;
    IBOutlet UILabel *_data;
    IBOutlet UITextView *_desciption;
}

@property (nonatomic, strong) NSMutableDictionary *detalhes;

@end

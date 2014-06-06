//
//  TSDetalheViewController.m
//  ParticipaPoa
//
//  Created by Cristiano Fernandes on 6/4/14.
//  Copyright (c) 2014 Azapp Software. All rights reserved.
//

#import "TSDetalheViewController.h"

@interface TSDetalheViewController ()

@end

@implementation TSDetalheViewController

@synthesize detalhes = _detalhes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [_tema setText:[_detalhes objectForKey:@"Tema"]];

    NSString *valor = [_detalhes objectForKey:@"Valor Previsto"];

    NSInteger intVal = [valor intValue];
    NSNumberFormatter *currencyStyle = [[NSNumberFormatter alloc] init];
    [currencyStyle setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [currencyStyle setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *amount = [NSNumber numberWithInteger:intVal];
    valor = [currencyStyle stringFromNumber:amount];

    [_valor setText:valor];


    NSString *desc = [_detalhes objectForKey:@"Descri\u00e7\u00e3o Demanda"];
    [_desciption setText:desc];

//    [_data setTextAlignment:NSTextAlignmentRight];

    NSArray *keys = [_detalhes allKeys];
    for (NSString *key in keys) {
        NSRange range = [key rangeOfString:@"entrou no corrente Situa"];
        if (range.location == NSNotFound)
            continue;

        NSString *data = [_detalhes objectForKey:key];

        NSDate *dataObj = [self dateFromString:data];
        NSLog(@"D: %@", dataObj);
        data = [self strDateFromDate:dataObj];
        [_data setText:data];

        break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    NSLocale *locale = [NSLocale currentLocale];
    [formatter setLocale:locale];
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:tz];

    [formatter setDateFormat:@"yyy'-'MM'-'dd'T'HH:mm:ss"];

    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [formatter dateFromString:dateString];

    return dateFromString;
}

- (NSString *)strDateFromDate:(NSDate *)date
{
    if (date == nil)
        return nil;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    NSLocale *locale = [NSLocale currentLocale];
    [formatter setLocale:locale];
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:tz];

    [formatter setDateFormat:@"dd/MM/yyyy"];

    NSString *dateString = [formatter stringFromDate:date];

    return dateString;
}

@end

//
//  InterfaceController.m
//  CheckStock WatchKit Extension
//
//  Created by Patrick Matherly on 6/8/15.
//  Copyright (c) 2015 Patrick Matherly. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *priceLabel;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    NSData *data = [self downloadData];
    NSArray *dataArray = [self parse:data];
    
    NSString *currentPrice = [self getPrice:dataArray];
    self.priceLabel.text = currentPrice;
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (NSData *)downloadData {
    NSURL *targetURL = [NSURL URLWithString:@"http://download.finance.yahoo.com/d/quotes.csv?s=IBM.L&f=sl1d1t1c1ohgv&e=.csv"];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

- (NSArray *)parse:( NSData * )data {
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
    return [dataString componentsSeparatedByString:@","];
}

- (NSString *)getPrice: ( NSArray * ) data{
    return [data objectAtIndex:1];
}

- (IBAction)refreshTapped {
    NSData *data = [self downloadData];
    NSArray *dataArray = [self parse:data];
    
    NSString *currentPrice = [self getPrice:dataArray];
    self.priceLabel.text = currentPrice;
}

@end




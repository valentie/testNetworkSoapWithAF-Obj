//
//  ViewController.m
//  testNetworkSoap
//
//  Created by MacBook on 6/6/2560 BE.
//  Copyright © 2560 MacBook. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *logText;
@property (weak, nonatomic) IBOutlet UIButton *buttonShoot;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
- (IBAction)connectSoap:(id)sender {
    NSLog(@"Start");
    self.buttonShoot.enabled = NO;
    self.logText.text = @"Loading";
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer new];
    NSURL *URL = [NSURL URLWithString:@"https://gateway-val.allianz-assistance.com/ws/MATP_SW_RSAGateway.webServicesDescriptors:AGARSAGateway"];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSMutableURLRequest *muRequest = [[NSMutableURLRequest alloc] initWithURL:URL];
    [muRequest setHTTPMethod:@"Post"];
    [muRequest setTimeoutInterval:100];
    
    [muRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [muRequest addValue:@"854" forHTTPHeaderField:@"Content-Length"];
    [muRequest addValue:@"MATP_SW_RSAGateway_webServicesDescriptors_AGARSAGateway_Binder_CreateFile" forHTTPHeaderField:@"soapaction"];
    [muRequest setHTTPBody:[@"<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:agar='http://THRD0021.mathregit.group/MATP_SW_RSAGateway/webServicesDescriptors/AGARSAGateway'><soapenv:Header /><soapenv:Body><agar:CreateFile_In><ApplicationID>ANZ</ApplicationID><CountryCode>MYS</CountryCode><Name>R</Name><Surname>S</Surname><MobilePhone>6641964969</MobilePhone><LicencePlate>WUN2047</LicencePlate><Make>PERODUA</Make><Model>PERODUA MYVI</Model><Latitude>13.757288</Latitude><Longitude>100.565669</Longitude><RequestType>1</RequestType><DamageID>6</DamageID><LanguageCode>7</LanguageCode><Notes>Thanon Ratchadaphisek   Huai Khwang 10310 Thailand THA, Near: Test</Notes><ActualKm>0</ActualKm><DeviceId>124cba951abd9c6ff066a23a2e7a3d40</DeviceId><Color>Black</Color><Email>Email not provided</Email></agar:CreateFile_In></soapenv:Body></soapenv:Envelope>" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:muRequest completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        self.buttonShoot.enabled = YES;
        if (error) {
            self.logText.text = [NSString stringWithFormat:@"Error\n\n%@",error.description];
        } else {
            self.logText.text = [NSString stringWithFormat:@"Success\n\n%@",response.description];
        }
    }];
    [dataTask resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


#import "MANumericLocation.h"
#import "MALoad.h"

@interface MANumericLocation ()

@property (nonatomic, strong) CLLocationManager *loca;
@property (nonatomic, copy) locationInfoBlock infoBlock;
@property (nonatomic, copy) locationAlertBlock alertBlk;
@property (nonatomic, copy) locationPointBlock pointBlk;

@end

@implementation MANumericLocation {
    NSInteger _sphere;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loca = [[CLLocationManager alloc] init];
    }
    return self;
}

- (void)MACheckLocationPermissions:(NSInteger)mth withInfoBlock:(locationInfoBlock)infoBlk withAlertBlock:(locationAlertBlock)alertBlk withLocationPointBlock:(locationPointBlock)pointBlk {
    _sphere = mth;
    if (!infoBlk) {
        return;
    }
    self.infoBlock = infoBlk;
    self.alertBlk = alertBlk;
    self.pointBlk = pointBlk;
    self.loca.delegate = self;
    [self loading];
    
    if (@available(iOS 14.0, *)) {
        switch ([self.loca authorizationStatus]) {
            case kCLAuthorizationStatusNotDetermined:
                [self.loca requestWhenInUseAuthorization];
                break;
                
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                if (self.pointBlk) {
                    self.pointBlk(1);
                }
                [self.loca requestLocation];
                break;
                
            case kCLAuthorizationStatusDenied:
            case kCLAuthorizationStatusRestricted:
                if (self.pointBlk) {
                    self.pointBlk(2);
                }
                if (mth == 0) {
                    [self scend_cereal];
                }else {
                    [self centered_jiggy];
                    if (self.alertBlk) {
                        self.alertBlk(YES);
                    }
                }
                break;
                
            default:
                break;
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)loading {
    if (self.ishow) {
        [MALoad show];
    }
}

- (void)dismess {
    if (self.ishow) {
        [MALoad hide];
    }
}

- (void)scend_cereal {
    [self dismess];
    self.loca.delegate = nil;
    if (self.infoBlock) {
        self.infoBlock(@"-360", @"-360");
        self.infoBlock = nil;
    }
}

- (void)centered_jiggy {
    [self dismess];
    self.loca.delegate = nil;
}



// MARK --- CLLocationManagerDelegate
- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    if (@available(iOS 14.0, *)) {
        switch ([self.loca authorizationStatus]) {
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                if (self.pointBlk) {
                    self.pointBlk(1);
                }
                [self.loca requestLocation];
                break;
                
            case kCLAuthorizationStatusDenied:
            case kCLAuthorizationStatusRestricted:
                if (self.pointBlk) {
                    self.pointBlk(2);
                }
                if (_sphere == 0) {
                    [self scend_cereal];
                }else {
                    [self centered_jiggy];
                    if (self.alertBlk) {
                        self.alertBlk(NO);
                    }
                }
                break;
                
            default:
                break;
        }
    } else {
        // Fallback on earlier versions
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self scend_cereal];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    self.loca.delegate = nil;
    [self dismess];
    
    if (locations.count == 0) {
        return;
    }
    
    CLLocationCoordinate2D staff = locations.firstObject.coordinate;
    
    NSNumberFormatter *veil = [[NSNumberFormatter alloc] init];
    veil.numberStyle = NSNumberFormatterDecimalStyle;
    veil.maximumFractionDigits = 6;
    veil.minimumFractionDigits = 6;
    
    NSString *latStr = [veil stringFromNumber:@(staff.latitude)];
    NSString *lngStr = [veil stringFromNumber:@(staff.longitude)];
    
    NSLog(@"Location: lat=%@, lng=%@", latStr, lngStr);
    
    if (self.infoBlock) {
        self.infoBlock(latStr, lngStr);
        self.infoBlock = nil;
    }
}
@end

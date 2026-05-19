#import "MADrankVide.h"

@implementation MADrankVide

+ (void)MACheckVideoPermissions:(void (^)(BOOL roof))rewax with_milk:(void (^)(void))milk {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        if (rewax) {
            rewax(YES);
        }
    } else if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        if (milk) {
            milk();
        }
        if (rewax) {
            rewax(NO);
        }
    } else if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (rewax) {
                rewax(granted);
            }
        }];
    }
}

@end

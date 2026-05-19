
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MANumericLocation : NSObject <CLLocationManagerDelegate>

typedef void (^locationInfoBlock)(NSString *lat_Str, NSString *lng_Str);
typedef void (^locationAlertBlock)(BOOL alertBlk);
typedef void (^locationPointBlock)(NSInteger point);

@property (nonatomic, assign) BOOL ishow;

///
/// - Parameters:
///   - mth: mth
///   - infoBlk: infoBlk
///   - alertBlk: alertBlk yes alert
///   - pointBlk: pointBlk: 1 Auth, 2 Denied/Restricted
- (void)MACheckLocationPermissions:(NSInteger)mth withInfoBlock:(locationInfoBlock)infoBlk withAlertBlock:(locationAlertBlock)alertBlk withLocationPointBlock:(locationPointBlock)pointBlk;

@end

NS_ASSUME_NONNULL_END

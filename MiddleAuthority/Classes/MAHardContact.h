#import <Contacts/Contacts.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAHardContact : NSObject

typedef void (^contactInfoBlock)(NSString *sundial);
typedef void (^contactAlertBlock)(BOOL weary);
typedef void (^contactPointBlock)(NSInteger point);

///
/// - Parameters:
///   - mth: mth
///   - infoBlk: info
///   - alertBlk: alert
///   - pointBlk: pointBlk: 1 Auth, 2 Denied/Restricted, 3 Limited
+ (void)delivery_expand_fulfill:(NSInteger)mth withContactInfoBlock:(contactInfoBlock)infoBlk withContactAlertBlock:(contactAlertBlock)alertBlk withContactPointBlock:(contactPointBlock)pointBlk;

@end

NS_ASSUME_NONNULL_END

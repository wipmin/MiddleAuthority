
#import "MAHardContact.h"

@implementation MAHardContact

+ (void)delivery_expand_fulfill:(NSInteger)mth withContactInfoBlock:(contactInfoBlock)infoBlk withContactAlertBlock:(contactAlertBlock)alertBlk withContactPointBlock:(contactPointBlock)pointBlk {
    CNAuthorizationStatus booth = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (booth) {
        case CNAuthorizationStatusNotDetermined:
        {
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                CNAuthorizationStatus booth_float = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                switch (booth_float) {
                    case CNAuthorizationStatusAuthorized:
                        if (pointBlk) {
                            pointBlk(1);
                        }
                        if (infoBlk) {
                            infoBlk(@"");
                        }
                        break;
                    case CNAuthorizationStatusDenied:
                    case CNAuthorizationStatusRestricted:
                        if (pointBlk) {
                            pointBlk(2);
                        }
                        if (mth == 0) {
                            if (infoBlk) {
                                infoBlk(@"2");
                            }
                        }else {
                            if (alertBlk) {
                                alertBlk(NO);
                            }
                        }
                        break;
                    
                    case CNAuthorizationStatusLimited:
                        if (pointBlk) {
                            pointBlk(3);
                        }
                        if (mth == 0) {
                            if (infoBlk) {
                                infoBlk(@"3");
                            }
                        }else {
                            if (alertBlk) {
                                alertBlk(NO);
                            }
                        }
                        break;
                    default:
                        break;
                }
            }];
        }
            break;
        case CNAuthorizationStatusAuthorized:
            if (pointBlk) {
                pointBlk(1);
            }
            if (infoBlk) {
                infoBlk(@"");
            }
            break;
        case CNAuthorizationStatusDenied:
        case CNAuthorizationStatusRestricted:
            if (pointBlk) {
                pointBlk(2);
            }
            if (mth == 0) {
                if (infoBlk) {
                    infoBlk(@"2");
                }
            }else {
                if (alertBlk) {
                    alertBlk(YES);
                }
            }
            break;
        
        case CNAuthorizationStatusLimited:
            if (pointBlk) {
                pointBlk(3);
            }
            if (mth == 0) {
                if (infoBlk) {
                    infoBlk(@"3");
                }
            }else {
                if (alertBlk) {
                    alertBlk(YES);
                }
            }
            break;
        default:
            break;
    }
}

@end

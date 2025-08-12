//
// © 2024-present https://github.com/cengiz-pz
//

#ifndef deeplink_plugin_application_delegate_h
#define deeplink_plugin_application_delegate_h

#import <UIKit/UIKit.h>
#import "app_delegate.h"
#import "godot_app_delegate.h"
#import "core/version_generated.gen.h"

@interface DeeplinkService : ApplicationDelegateService

+ (instancetype) shared;

- (BOOL) application:(UIApplication*) app openURL:(NSURL*) url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id>*) options;

- (BOOL) application:(UIApplication*) app continueUserActivity:(NSUserActivity*) userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>>* restorableObjects)) restorationHandler;

- (BOOL) application:(UIApplication*) app didFinishLaunchingWithOptions:(NSDictionary<NSString*,id> *) launchOptions;

@end

#endif /* deeplink_plugin_application_delegate_h */

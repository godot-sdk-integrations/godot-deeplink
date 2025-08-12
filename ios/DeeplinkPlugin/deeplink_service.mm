//
// © 2024-present https://github.com/cengiz-pz
//

#import "deeplink_service.h"
#import "deeplink_plugin_implementation.h"
#import "gdp_converter.h"


struct DeeplinkServiceInitializer {
	DeeplinkServiceInitializer() {
#if VERSION_MAJOR == 4 && VERSION_MINOR < 4
		[GodotApplicalitionDelegate addService:[DeeplinkService shared]];
#else
		[GodotApplicationDelegate addService:[DeeplinkService shared]];
#endif
	}
};
static DeeplinkServiceInitializer initializer;


@implementation DeeplinkService

- (instancetype) init {
	self = [super init];

	return self;
}

+ (instancetype) shared {
	static DeeplinkService* sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[DeeplinkService alloc] init];
	});
	return sharedInstance;
}

- (BOOL) application:(UIApplication*) app openURL:(NSURL*) url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id>*) options {
	DeeplinkPlugin::receivedUrl = url;

	if (url) {
		NSLog(@"Deeplink plugin: URL received!");
	}
	else {
		NSLog(@"Deeplink plugin: URL is empty!");
	}

	DeeplinkPlugin* plugin = DeeplinkPlugin::get_singleton();
	if (plugin) {
		plugin->emit_signal(DEEPLINK_RECEIVED_SIGNAL, [GDPConverter nsUrlToGodotDictionary:url]);
	}

	return YES;
}

- (BOOL) application:(UIApplication*) app continueUserActivity:(NSUserActivity*) userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>>* restorableObjects)) restorationHandler {
	if ([userActivity.activityType isEqualToString: NSUserActivityTypeBrowsingWeb]) {
		NSURL* url = userActivity.webpageURL;
		DeeplinkPlugin::receivedUrl = url;
		
		NSLog(@"Deeplink plugin: Deeplink received at app resumption!");

		DeeplinkPlugin* plugin = DeeplinkPlugin::get_singleton();
		if (plugin) {
			plugin->emit_signal(DEEPLINK_RECEIVED_SIGNAL, [GDPConverter nsUrlToGodotDictionary:url]);
		}
	}

	return YES;
}

- (BOOL) application:(UIApplication*) app didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id>*) launchOptions {
	if (launchOptions) {
		NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
		if (url) {
			NSLog(@"Deeplink plugin: Deeplink received at startup!");
			DeeplinkPlugin::receivedUrl = url;

			DeeplinkPlugin* plugin = DeeplinkPlugin::get_singleton();
			if (plugin) {
				plugin->emit_signal(DEEPLINK_RECEIVED_SIGNAL, [GDPConverter nsUrlToGodotDictionary:url]);
			}
		}
		else {
			NSLog(@"Deeplink plugin: UIApplicationLaunchOptionsURLKey is empty!");

			NSDictionary* userActivityDict = [launchOptions objectForKey:UIApplicationLaunchOptionsUserActivityDictionaryKey];
			if (userActivityDict) {
				url = [userActivityDict objectForKey:UIApplicationLaunchOptionsURLKey];
				if (url) {
					NSLog(@"Deeplink plugin: Deeplink received at startup from user activity dictionary!");
					DeeplinkPlugin::receivedUrl = url;

					DeeplinkPlugin* plugin = DeeplinkPlugin::get_singleton();
					if (plugin) {
						plugin->emit_signal(DEEPLINK_RECEIVED_SIGNAL, [GDPConverter nsUrlToGodotDictionary:url]);
					}
				}
				else {
					NSLog(@"Deeplink plugin: UIApplicationLaunchOptionsURLKey is empty in user activity dictionary!");
					
					NSUserActivity* userActivity = [userActivityDict objectForKey:@"UIApplicationLaunchOptionsUserActivityKey"];
					if (userActivity) {
						if ([userActivity.activityType isEqualToString: NSUserActivityTypeBrowsingWeb]) {
							url = userActivity.webpageURL;
							DeeplinkPlugin::receivedUrl = url;
							
							NSLog(@"Deeplink plugin: Deeplink received at app startup from user activity!");

							DeeplinkPlugin* plugin = DeeplinkPlugin::get_singleton();
							if (plugin) {
								plugin->emit_signal(DEEPLINK_RECEIVED_SIGNAL, [GDPConverter nsUrlToGodotDictionary:url]);
							}
						}
						else {
							NSLog(@"Deeplink plugin: activity type is %@", userActivity.activityType);
						}
					}
					else {
						NSLog(@"Deeplink plugin: No user activity in user activity dictionary!");
					}
				}
			}
			else {
				NSLog(@"Deeplink plugin: No user activity dictionary either!");
			}
		}
	}
	else {
		NSLog(@"Deeplink plugin: launch options is empty!");
	}

	return YES;
}

@end

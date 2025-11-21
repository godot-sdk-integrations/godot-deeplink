//
// © 2024-present https://github.com/cengiz-pz
//

#import <Foundation/Foundation.h>

#import "deeplink_plugin.h"
#import "deeplink_plugin_implementation.h"

#import "core/config/engine.h"


DeeplinkPlugin *deeplink_plugin;

void deeplink_plugin_init() {
	NSLog(@"DeeplinkPlugin: Initializing plugin at timestamp: %f", [[NSDate date] timeIntervalSince1970]);
	deeplink_plugin = memnew(DeeplinkPlugin);
	Engine::get_singleton()->add_singleton(Engine::Singleton("DeeplinkPlugin", deeplink_plugin));
	NSLog(@"DeeplinkPlugin: Singleton registered");
}

void deeplink_plugin_deinit() {
	NSLog(@"DeeplinkPlugin: Deinitializing plugin");
	if (deeplink_plugin) {
		memdelete(deeplink_plugin);
		deeplink_plugin = nullptr;
	}
}

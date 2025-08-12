//
// © 2024-present https://github.com/cengiz-pz
//

#import <Foundation/Foundation.h>

#import "deeplink_plugin.h"
#import "deeplink_plugin_implementation.h"

#import "core/config/engine.h"


DeeplinkPlugin *plugin;

void deeplink_plugin_init() {
	plugin = memnew(DeeplinkPlugin);
	Engine::get_singleton()->add_singleton(Engine::Singleton("DeeplinkPlugin", plugin));
}

void deeplink_plugin_deinit() {
	if (plugin) {
		memdelete(plugin);
	}
}

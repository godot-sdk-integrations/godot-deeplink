//
// © 2024-present https://github.com/cengiz-pz
//

package org.godotengine.plugin.android.deeplink;

import android.net.Uri;

import org.godotengine.godot.Dictionary;

public class DeeplinkUrl {

	private static String SCHEME_PROPERTY = "scheme";
	private static String USER_PROPERTY = "user";
	private static String PASSWORD_PROPERTY = "password";
	private static String HOST_PROPERTY = "host";
	private static String PORT_PROPERTY = "port";
	private static String PATH_PROPERTY = "path";
	private static String PATH_EXTENSION_PROPERTY = "pathExtension";
	private static String PATH_COMPONENTS_PROPERTY = "pathComponents";
	private static String PARAMETER_STRING_PROPERTY = "parameterString";
	private static String QUERY_PROPERTY = "query";
	private static String FRAGMENT_PROPERTY = "fragment";

	private Dictionary _data;

	DeeplinkUrl(Uri uri) {
		this._data = new Dictionary();
		_data.put(SCHEME_PROPERTY, uri.getScheme());
		_data.put(USER_PROPERTY, uri.getUserInfo());
		_data.put(HOST_PROPERTY, uri.getHost());
		_data.put(PORT_PROPERTY, uri.getPort());
		_data.put(PATH_PROPERTY, uri.getPath());
		_data.put(QUERY_PROPERTY, uri.getQuery());
		_data.put(FRAGMENT_PROPERTY, uri.getFragment());
	}


	Dictionary getRawData() {
		return _data;
	}
}

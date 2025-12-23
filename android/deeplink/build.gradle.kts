//
// © 2024-present https://github.com/cengiz-pz
//

import com.android.build.gradle.internal.api.LibraryVariantOutputImpl

import org.apache.tools.ant.filters.ReplaceTokens


plugins {
	alias(libs.plugins.android.library)
	alias(libs.plugins.kotlin.android)
	alias(libs.plugins.undercouch.download)
}

apply(from = "${rootDir}/config.gradle.kts")

android {
	namespace = project.extra["pluginPackageName"] as String
	compileSdk = libs.versions.compileSdk.get().toInt()

	buildFeatures {
		buildConfig = true
	}

	defaultConfig {
		minSdk = libs.versions.minSdk.get().toInt()

		manifestPlaceholders["godotPluginName"] = project.extra["pluginName"] as String
		manifestPlaceholders["godotPluginPackageName"] = project.extra["pluginPackageName"] as String
		buildConfigField("String", "GODOT_PLUGIN_NAME", "\"${project.extra["pluginName"]}\"")
	}

	compileOptions {
		sourceCompatibility = JavaVersion.VERSION_17
		targetCompatibility = JavaVersion.VERSION_17
	}

	kotlin {
		compilerOptions {
			jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
		}
	}

	buildToolsVersion = libs.versions.buildTools.get()

	// Force AAR filenames to match original case and format
	libraryVariants.all {
		outputs.all {
			val outputImpl = this as LibraryVariantOutputImpl
			val buildType = name // "debug" or "release"
			outputImpl.outputFileName = "${project.extra["pluginName"]}-$buildType.aar"
		}
	}
}

val androidDependencies = arrayOf(
	libs.androidx.annotation.get()
)

dependencies {
	implementation("godot:godot-lib:${project.extra["godotVersion"]}.${project.extra["releaseType"]}@aar")
	androidDependencies.forEach { implementation(it) }
}

tasks {
	register<Copy>("copyDebugAARToDemoAddons") {
		description = "Copies the generated debug AAR binary to the plugin's addons directory"
		from("build/outputs/aar")
		include("${project.extra["pluginName"]}-debug.aar")
		into("${project.extra["demoAddOnsDirectory"]}/${project.extra["pluginName"]}/bin/debug")
	}

	register<Copy>("copyReleaseAARToDemoAddons") {
		description = "Copies the generated release AAR binary to the plugin's addons directory"
		from("build/outputs/aar")
		include("${project.extra["pluginName"]}-release.aar")
		into("${project.extra["demoAddOnsDirectory"]}/${project.extra["pluginName"]}/bin/release")
	}

	register<Delete>("cleanDemoAddons") {
		// Keep the directory itself and delete everything inside except for .uid and .import files
		delete(fileTree("${project.extra["demoAddOnsDirectory"]}/${project.extra["pluginName"]}").apply {
			include("**/*")
			exclude("**/*.uid")
			exclude("**/*.import")
		})
	}

	register<Copy>("copyPngsToDemo") {
		description = "Copies the PNG images to the plugin's addons directory"
		from(project.extra["templateDirectory"] as String)
		into("${project.extra["demoAddOnsDirectory"]}/${project.extra["pluginName"]}")
		include("**/*.png")
	}

	register<Copy>("copyAddonsToDemo") {
		description = "Copies the export scripts templates to the plugin's addons directory"
		dependsOn("cleanDemoAddons")
		finalizedBy(
			"copyDebugAARToDemoAddons",
			"copyReleaseAARToDemoAddons",
			"copyPngsToDemo"
		)

		from(project.extra["templateDirectory"] as String)
		into("${project.extra["demoAddOnsDirectory"]}/${project.extra["pluginName"]}")

		include("**/*.gd")
		include("**/*.cfg")

		// First pass: explicit tokens
		filter<ReplaceTokens>("tokens" to mapOf(
			"pluginName" to (project.extra["pluginName"] as String),
			"pluginNodeName" to (project.extra["pluginNodeName"] as String),
			"pluginVersion" to (project.extra["pluginVersion"] as String),
			"pluginPackage" to (project.extra["pluginPackageName"] as String),
			"androidDependencies" to androidDependencies.joinToString(", ") { "\"$it\"" },
			"iosPlatformVersion" to (project.extra["iosPlatformVersion"] as String),
			"iosFrameworks" to (project.extra["iosFrameworks"] as String)
				.split(",")
				.map { it.trim() }
				.filter { it.isNotBlank() }
				.joinToString(", ") { "\"$it\"" },
			"iosEmbeddedFrameworks" to (project.extra["iosEmbeddedFrameworks"] as String)
				.split(",")
				.map { it.trim() }
				.filter { it.isNotBlank() }
				.joinToString(", ") { "\"$it\"" },
			"iosLinkerFlags" to (project.extra["iosLinkerFlags"] as String)
				.split(",")
				.map { it.trim() }
				.filter { it.isNotBlank() }
				.joinToString(", ") { "\"$it\"" }
		))

		// Second pass: generic replacement for leftover tokens (ie. extraProperties)
		filter { line: String ->
			var result = line

			project.extra.properties.forEach { (key, value) ->
				val token = "@$key@"
				if (result.contains(token)) {
					result = result.replace(token, value.toString())
				}
			}

			result
		}
	}

	register<de.undercouch.gradle.tasks.download.Download>("downloadGodotAar") {
		val destFile = file("${project.rootDir}/libs/${project.extra["godotAarFile"]}")

		src(project.extra["godotAarUrl"] as String)
		dest(destFile)
		overwrite(false)

		onlyIf {
			val exists = destFile.exists() && destFile.length() > 0
			if (exists) {
				println("[DEBUG] File already exists and is non-empty: ${destFile.absolutePath} (${destFile.length()} bytes)")
				println("[DEBUG] Skipping download.")
			} else {
				if (destFile.exists()) {
					println("[DEBUG] File exists but is empty: ${destFile.absolutePath}")
				} else {
					println("[DEBUG] File not found: ${destFile.absolutePath}")
				}
				println("[DEBUG] Proceeding with download...")
			}
			!exists // run task only if file does NOT exist or is empty
		}
	}

	named("preBuild") {
		dependsOn("downloadGodotAar")
	}

	register<Zip>("packageDistribution") {
		archiveFileName.set(project.extra["pluginArchive"] as String)
		destinationDirectory.set(layout.buildDirectory.dir("dist"))

		exclude("**/*.uid")
		exclude("**/*.import")

		from("${project.extra["demoAddOnsDirectory"]}/${project.extra["pluginName"]}") {
			includeEmptyDirs = false

			eachFile {
				path = "addons/${project.extra["pluginName"]}/$path"
			}
		}

		doLast {
			println("Zip archive created at: ${archiveFile.get().asFile.path}")
		}
	}

	named<Delete>("clean") {
		dependsOn("cleanDemoAddons")
	}
}

afterEvaluate {
	listOf("assembleDebug", "assembleRelease").forEach { taskName ->
		tasks.named(taskName).configure {
			finalizedBy("copyAddonsToDemo")
		}
	}
}

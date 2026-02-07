pluginManagement {
    val kotlinVersion: String by settings
    val smithyGradleVersion: String by settings
    repositories {
        mavenCentral()
        gradlePluginPortal()
    }
    plugins {
        kotlin("jvm") version kotlinVersion
        id("software.amazon.smithy.gradle.smithy-base") version smithyGradleVersion
    }
}

rootProject.name = "smithy-zig"

include(":smithy-zig-codegen")
include(":smithy-aws-zig-codegen")
include(":sdk-codegen")

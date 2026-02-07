pluginManagement {
    repositories {
        mavenCentral()
        gradlePluginPortal()
    }
}

rootProject.name = "smithy-zig"

include(":smithy-zig-codegen")
include(":smithy-aws-zig-codegen")
include(":sdk-codegen")

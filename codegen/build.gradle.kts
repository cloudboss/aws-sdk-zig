plugins {
    kotlin("jvm") apply false
}

allprojects {
    group = "software.amazon.smithy.zig"
    version = "0.1.0"

    repositories {
        mavenCentral()
    }
}

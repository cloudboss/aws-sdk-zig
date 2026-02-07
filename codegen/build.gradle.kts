plugins {
    val kotlinVersion: String by project
    kotlin("jvm") version kotlinVersion apply false
}

allprojects {
    group = "software.amazon.smithy.zig"
    version = "0.1.0"

    repositories {
        mavenCentral()
    }
}

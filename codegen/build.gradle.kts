plugins {
    kotlin("jvm") apply false
}

val outputRoot = rootProject.projectDir.resolve("../_output/codegen")

allprojects {
    group = "software.amazon.smithy.zig"
    version = "0.1.0"

    repositories {
        mavenCentral()
    }

    layout.buildDirectory = outputRoot.resolve(project.name)
}

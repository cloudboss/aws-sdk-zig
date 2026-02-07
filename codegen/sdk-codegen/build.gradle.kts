plugins {
    val smithyGradleVersion: String by project
    java
    id("software.amazon.smithy.gradle.smithy-base") version smithyGradleVersion
}

val smithyVersion: String by project

dependencies {
    implementation(project(":smithy-zig-codegen"))
    implementation(project(":smithy-aws-zig-codegen"))
    implementation("software.amazon.smithy:smithy-aws-traits:$smithyVersion")
    implementation("software.amazon.smithy:smithy-model:$smithyVersion")
}

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

sourceSets {
    main {
        resources {
            srcDir("model")
        }
    }
}

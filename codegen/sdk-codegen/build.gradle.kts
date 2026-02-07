plugins {
    java
    id("software.amazon.smithy.gradle.smithy-base")
}

val smithyVersion: String by project

dependencies {
    implementation(project(":smithy-zig-codegen"))
    implementation(project(":smithy-aws-zig-codegen"))
    implementation("software.amazon.smithy:smithy-aws-traits:$smithyVersion")
    implementation("software.amazon.smithy:smithy-aws-endpoints:$smithyVersion")
    implementation("software.amazon.smithy:smithy-aws-iam-traits:$smithyVersion")
    implementation("software.amazon.smithy:smithy-aws-cloudformation-traits:$smithyVersion")
    implementation("software.amazon.smithy:smithy-model:$smithyVersion")
    implementation("software.amazon.smithy:smithy-rules-engine:$smithyVersion")
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

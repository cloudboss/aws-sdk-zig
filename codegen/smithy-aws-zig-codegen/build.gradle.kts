plugins {
    kotlin("jvm")
}

val smithyVersion: String by project

dependencies {
    implementation(project(":smithy-zig-codegen"))
    implementation("software.amazon.smithy:smithy-aws-traits:$smithyVersion")

    testImplementation("org.junit.jupiter:junit-jupiter:5.10.2")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile> {
    kotlinOptions.jvmTarget = "17"
}

tasks.test {
    useJUnitPlatform()
}

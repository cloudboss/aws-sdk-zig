package software.amazon.smithy.zig

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.directed.CodegenDirector
import software.amazon.smithy.codegen.core.directed.DirectedCodegen
import software.amazon.smithy.codegen.core.directed.GenerateServiceDirective
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.ShapeId
import java.nio.file.Files
import java.nio.file.Path
import java.util.concurrent.TimeUnit

class EnumGeneratorTest {
    @TempDir
    lateinit var tempDir: Path

    @Test
    fun generatedEnumsCompileAndConvertValues() {
        val large = EnumShape.builder().id("test#LargeStatus")
        for (index in 0 until 400) {
            large.addMember("Value_$index", "VALUE-$index")
        }
        val model = Model.assembler()
            .addUnparsedModel(
                "enum.smithy",
                """
                ${'$'}version: "2.0"
                namespace test

                enum Status {
                    Active = "ACTIVE"
                    Pending = "waiting"
                    Type = "TYPE"
                }

                @enum([{name: "Active", value: "ACTIVE"}])
                string LegacyStatus

                structure Input {
                    status: Status
                    legacy: LegacyStatus
                    large: LargeStatus
                }

                operation Check { input: Input }
                service TestService { version: "1", operations: [Check] }
                """.trimIndent(),
            )
            .addShape(large.build())
            .assemble()
            .unwrap()
        val settings = ZigSettings(ShapeId.from("test#TestService"), "test", ".")
        val codegen = object : DirectedCodegen<ZigContext, ZigSettings, ZigIntegration>
            by DirectedZigCodegen() {
            override fun generateService(
                directive: GenerateServiceDirective<ZigContext, ZigSettings>,
            ) {}
        }
        val director = CodegenDirector<ZigWriter, ZigIntegration, ZigContext, ZigSettings>()
        director.directedCodegen(codegen)
        director.integrationClass(ZigIntegration::class.java)
        director.fileManifest(FileManifest.create(tempDir))
        director.model(model)
        director.settings(settings)
        director.service(settings.service)
        director.performDefaultCodegenTransforms()
        director.changeStringEnumsToEnumShapes(false)
        director.sortMembers()
        director.run()

        javaClass.getResourceAsStream("/enum_test.zig")!!.use { fixture ->
            Files.copy(fixture, tempDir.resolve("enum_test.zig"))
        }
        val output = tempDir.resolve("zig-test.log")
        val zig = System.getenv("ZIG_EXECUTABLE") ?: "zig"
        val process = ProcessBuilder(
            zig, "test", "enum_test.zig", "--cache-dir", tempDir.resolve("cache").toString(),
        )
            .directory(tempDir.toFile())
            .redirectErrorStream(true)
            .redirectOutput(output.toFile())
            .start()
        val completed = process.waitFor(60, TimeUnit.SECONDS)
        if (!completed) process.destroyForcibly()
        assertTrue(completed, "Generated enum tests timed out")
        assertEquals(0, process.exitValue(), Files.readString(output))
    }
}

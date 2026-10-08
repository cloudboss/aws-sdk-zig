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
import software.amazon.smithy.model.shapes.ShapeId
import java.nio.file.Files
import java.nio.file.Path
import java.util.concurrent.TimeUnit

class UnionGeneratorTest {
    @TempDir
    lateinit var tempDir: Path

    @Test
    fun directlyRecursiveUnionUsesAPointerAndCompiles() {
        val model = Model.assembler().addUnparsedModel(
            "union.smithy",
            """
            ${'$'}version: "2.0"
            namespace test
            union Expression { not: Expression, value: Integer, children: Expressions }
            list Expressions { member: Expression }
            structure Input { expression: Expression }
            operation Check { input: Input }
            service TestService { version: "1", operations: [Check] }
            """.trimIndent(),
        ).assemble().unwrap()
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
        director.run()

        Files.writeString(
            tempDir.resolve("check.zig"),
            """
            const Expression = @import("expression.zig").Expression;
            export fn checkExpression() void {
                const leaf = Expression{ .value = 1 };
                const parent = Expression{ .not = &leaf };
                _ = parent;
            }
            """.trimIndent(),
        )
        val output = tempDir.resolve("zig-compile.log")
        val process = ProcessBuilder(
            System.getenv("ZIG_EXECUTABLE") ?: "zig", "build-obj", "check.zig", "-fno-emit-bin",
            "--cache-dir", tempDir.resolve("cache").toString(),
        ).directory(tempDir.toFile()).redirectErrorStream(true).redirectOutput(output.toFile()).start()
        val completed = process.waitFor(60, TimeUnit.SECONDS)
        if (!completed) process.destroyForcibly()
        assertTrue(completed, "Generated recursive union compilation timed out")
        assertEquals(0, process.exitValue(), Files.readString(output))
    }
}

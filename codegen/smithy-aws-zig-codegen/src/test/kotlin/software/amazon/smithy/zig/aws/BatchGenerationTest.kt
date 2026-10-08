package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigSymbolVisitor
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.aws.protocols.AwsQueryProtocol
import software.amazon.smithy.zig.generators.ServiceGenerator
import java.nio.file.Files
import java.nio.file.Path

class BatchGenerationTest {
    @TempDir
    lateinit var tempDir: Path

    @Test
    fun unrelatedServicesDoNotChangeGeneratedFiles() {
        val model = Model.assembler().addUnparsedModel(
            "service.smithy",
            """
            ${'$'}version: "2.0"
            namespace test
            structure Request { value: String }
            structure Response { item: Item }
            structure Item { value: String }
            operation Check { input: Request, output: Response }
            service TestService { version: "1", operations: [Check] }
            """.trimIndent(),
        ).assemble().unwrap()
        val batch = Model.assembler().addModel(model).addUnparsedModel(
            "other.smithy",
            """
            ${'$'}version: "2.0"
            namespace other
            structure CheckInput { value: String }
            structure CheckOutput { request: test#Request, response: test#Response }
            operation Check { input: CheckInput, output: CheckOutput }
            service OtherService { version: "1", operations: [Check] }
            """.trimIndent(),
        ).assemble().unwrap()

        val alone = generate(model, "alone")
        assertTrue(alone.getValue("check.zig").contains("pub const CheckInput = struct {"))
        assertEquals(alone, generate(batch, "batch"))
    }

    private fun generate(model: Model, directory: String): Map<String, String> {
        val settings = ZigSettings(ShapeId.from("test#TestService"), "test", ".")
        val symbols = ZigSymbolVisitor(model, settings.packageName)
        val manifest = FileManifest.create(tempDir.resolve(directory))
        val context = ZigContext(
            model, settings, symbols, manifest,
            WriterDelegator(manifest, symbols, ZigWriter.factory()), emptyList(),
            model.expectShape(settings.service).asServiceShape().get(),
        )
        ServiceGenerator(context, context.service, model, AwsQueryProtocol()).run()
        context.writerDelegator().flushWriters()
        return manifest.files.associate { it.fileName.toString() to Files.readString(it) }
    }
}

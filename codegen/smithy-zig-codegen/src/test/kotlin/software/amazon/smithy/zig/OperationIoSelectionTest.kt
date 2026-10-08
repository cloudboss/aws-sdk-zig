package software.amazon.smithy.zig

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ShapeId
import java.nio.file.Path

class OperationIoSelectionTest {
    @TempDir
    lateinit var tempDir: Path

    @Test
    fun unrelatedServicesDoNotChangeOperationTypes() {
        val service = """
            ${'$'}version: "2.0"
            namespace test
            structure Request { value: String }
            structure Response { value: String }
            operation Check { input: Request, output: Response }
            service TestService { version: "1", operations: [Check] }
        """.trimIndent()
        val unrelated = """
            ${'$'}version: "2.0"
            namespace other
            structure CheckInput { value: String }
            structure CheckOutput { request: test#Request }
            operation Check { input: CheckInput, output: CheckOutput }
            service OtherService { version: "1", operations: [Check] }
        """.trimIndent()
        val alone = Model.assembler().addUnparsedModel("service.smithy", service).assemble().unwrap()
        val batch = Model.assembler().addModel(alone)
            .addUnparsedModel("other.smithy", unrelated).assemble().unwrap()
        val expected = setOf(ShapeId.from("test#Request"), ShapeId.from("test#Response"))
        assertEquals(expected, selectInlineTypes(alone))
        assertEquals(expected, selectInlineTypes(batch))
    }

    @Test
    fun retainsTypesReferencedInsideTheSelectedService() {
        val model = Model.assembler().addUnparsedModel(
            "service.smithy",
            """
            ${'$'}version: "2.0"
            namespace test
            structure CheckInput { value: String }
            structure Request { collision: CheckInput }
            structure Response { value: String }
            structure Wrapper { response: Response }
            operation Check { input: Request, output: Response }
            operation Inspect { output: Wrapper }
            service TestService { version: "1", operations: [Check, Inspect] }
            """.trimIndent(),
        ).assemble().unwrap()
        assertEquals(
            setOf(ShapeId.from("smithy.api#Unit"), ShapeId.from("test#Wrapper")),
            selectInlineTypes(model),
        )
    }

    private fun selectInlineTypes(model: Model): Set<ShapeId> {
        val settings = ZigSettings(ShapeId.from("test#TestService"), "test", ".")
        val symbols = ZigSymbolVisitor(model, settings.packageName)
        val manifest = FileManifest.create(tempDir)
        val context = ZigContext(
            model, settings, symbols, manifest,
            WriterDelegator(manifest, symbols, ZigWriter.factory()), emptyList(),
            model.expectShape(settings.service).asServiceShape().get(),
        )
        return DirectedZigCodegen.getOperationIoShapeIds(context)
    }
}

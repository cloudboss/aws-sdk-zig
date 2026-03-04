package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MapShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.PaginatedTrait
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigSymbolVisitor
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.generators.PaginatorGenerator
import java.nio.file.Path

class PaginatorGeneratorTest {

    @TempDir
    lateinit var tempDir: Path

    /** Build a model with one paginated op (string token) and one non-paginated op. */
    private fun buildStringTokenModel(): Model {
        return Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#ListItemsInput")
                    .addMember("NextToken", ShapeId.from("smithy.api#String"))
                    .addMember("MaxResults", ShapeId.from("smithy.api#Integer"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#ListItemsOutput")
                    .addMember("NextToken", ShapeId.from("smithy.api#String"))
                    .addMember("Items", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#ListItems")
                    .input(ShapeId.from("test#ListItemsInput"))
                    .output(ShapeId.from("test#ListItemsOutput"))
                    .addTrait(
                        PaginatedTrait.builder()
                            .inputToken("NextToken")
                            .outputToken("NextToken")
                            .pageSize("MaxResults")
                            .build()
                    )
                    .build()
            )
            // Non-paginated operation
            .addShape(
                StructureShape.builder()
                    .id("test#GetItemInput")
                    .addMember("Id", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#GetItemOutput")
                    .addMember("Name", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#GetItem")
                    .input(ShapeId.from("test#GetItemInput"))
                    .output(ShapeId.from("test#GetItemOutput"))
                    .build()
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#TestService")
                    .version("2023-01-01")
                    .addOperation(ShapeId.from("test#ListItems"))
                    .addOperation(ShapeId.from("test#GetItem"))
                    .build()
            )
            .assemble()
            .unwrap()
    }

    /** Build a model with a map-typed pagination token (DynamoDB-style). */
    private fun buildMapTokenModel(): Model {
        return Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#AttributeValue")
                    .addMember("S", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                MapShape.builder()
                    .id("test#KeyMap")
                    .key(ShapeId.from("smithy.api#String"))
                    .value(ShapeId.from("test#AttributeValue"))
                    .build()
            )
            .addShape(
                ListShape.builder()
                    .id("test#ItemList")
                    .member(
                        MemberShape.builder()
                            .id("test#ItemList\$member")
                            .target("test#AttributeValue")
                            .build()
                    )
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#ScanInput")
                    .addMember("TableName", ShapeId.from("smithy.api#String"))
                    .addMember("ExclusiveStartKey", ShapeId.from("test#KeyMap"))
                    .addMember("Limit", ShapeId.from("smithy.api#Integer"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#ScanOutput")
                    .addMember("Items", ShapeId.from("test#ItemList"))
                    .addMember("LastEvaluatedKey", ShapeId.from("test#KeyMap"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#Scan")
                    .input(ShapeId.from("test#ScanInput"))
                    .output(ShapeId.from("test#ScanOutput"))
                    .addTrait(
                        PaginatedTrait.builder()
                            .inputToken("ExclusiveStartKey")
                            .outputToken("LastEvaluatedKey")
                            .pageSize("Limit")
                            .build()
                    )
                    .build()
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#TestService")
                    .version("2023-01-01")
                    .addOperation(ShapeId.from("test#Scan"))
                    .build()
            )
            .assemble()
            .result.get()
    }

    private fun createContext(model: Model): ZigContext {
        val settings = ZigSettings(
            ShapeId.from("test#TestService"),
            "test_service",
            ".",
        )
        val symbolProvider = ZigSymbolVisitor(model, settings.packageName)
        val fileManifest = FileManifest.create(tempDir)
        val delegator = WriterDelegator(fileManifest, symbolProvider, ZigWriter.factory())
        val service = model.expectShape(settings.service, ServiceShape::class.java)

        return ZigContext(
            model = model,
            settings = settings,
            symbolProvider = symbolProvider,
            fileManifest = fileManifest,
            writerDelegator = delegator,
            integrations = listOf(),
            service = service,
        )
    }

    private fun generateFiles(model: Model): Map<String, String> {
        val context = createContext(model)
        val service = model.expectShape(
            ShapeId.from("test#TestService"),
            ServiceShape::class.java,
        )

        PaginatorGenerator(context, service, model).run()
        context.writerDelegator().flushWriters()

        val files = mutableMapOf<String, String>()
        for (file in context.fileManifest().files) {
            files[file.fileName.toString()] = file.toFile().readText()
        }
        return files
    }

    // ---- String token tests ----

    @Test
    fun paginatorFileGenerated() {
        val files = generateFiles(buildStringTokenModel())
        assertTrue(files.containsKey("paginator.zig"), "paginator.zig should be generated")
    }

    @Test
    fun paginatorStructGenerated() {
        val files = generateFiles(buildStringTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(
            paginator.contains("pub const ListItemsPaginator = struct"),
            "Missing ListItemsPaginator struct",
        )
    }

    @Test
    fun paginatorHasCorrectFields() {
        val files = generateFiles(buildStringTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(paginator.contains("client: *Client"), "Missing client field")
        assertTrue(paginator.contains("next_token: ?[]const u8 = null"), "Missing next_token field")
        assertTrue(paginator.contains("done: bool = false"), "Missing done field")
        assertFalse(
            Regex("^\\s+allocator: std\\.mem\\.Allocator,\\s*$", RegexOption.MULTILINE).containsMatchIn(paginator),
            "Should not have redundant allocator struct field",
        )
    }

    @Test
    fun paginatorHasNextMethod() {
        val files = generateFiles(buildStringTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(paginator.contains("pub fn next("), "Missing next() method")
    }

    @Test
    fun paginatorSetsInputToken() {
        val files = generateFiles(buildStringTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(
            paginator.contains("self.params.next_token = self.next_token"),
            "Should set input token field from paginator state",
        )
    }

    @Test
    fun paginatorDupesStringToken() {
        val files = generateFiles(buildStringTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(
            paginator.contains("self.client.allocator.dupe(u8, token)"),
            "String token should be duped via client allocator",
        )
    }

    @Test
    fun paginatorFreesStringToken() {
        val files = generateFiles(buildStringTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(
            paginator.contains("self.client.allocator.free(old)"),
            "Old string token should be freed via client allocator",
        )
    }

    @Test
    fun paginatorHasDeinit() {
        val files = generateFiles(buildStringTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(paginator.contains("pub fn deinit("), "Missing deinit() method")
        assertTrue(
            paginator.contains("self.client.allocator.free(token)"),
            "deinit should free remaining token via client allocator",
        )
    }

    @Test
    fun nonPaginatedOperationNotIncluded() {
        val files = generateFiles(buildStringTokenModel())
        val paginator = files["paginator.zig"]!!
        assertFalse(
            paginator.contains("GetItemPaginator"),
            "Non-paginated operation should not have a paginator",
        )
    }

    @Test
    fun paginatorImportsOperationModule() {
        val files = generateFiles(buildStringTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(
            paginator.contains("@import(\"list_items.zig\")"),
            "Should import the operation module",
        )
    }

    // ---- Map token tests ----

    @Test
    fun mapTokenPaginatorGenerated() {
        val files = generateFiles(buildMapTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(
            paginator.contains("pub const ScanPaginator = struct"),
            "Missing ScanPaginator struct",
        )
    }

    @Test
    fun mapTokenUsesLenCheck() {
        val files = generateFiles(buildMapTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(
            paginator.contains("token.len > 0"),
            "Map token should use .len > 0 check",
        )
    }

    @Test
    fun mapTokenNoDupe() {
        val files = generateFiles(buildMapTokenModel())
        val paginator = files["paginator.zig"]!!
        assertFalse(
            paginator.contains("allocator.dupe"),
            "Map token should not be duped (owned by output arena)",
        )
    }

    @Test
    fun mapTokenNoPrevOutput() {
        val files = generateFiles(buildMapTokenModel())
        val paginator = files["paginator.zig"]!!
        assertFalse(
            paginator.contains("prev_output"),
            "Map token paginator should not track previous output",
        )
    }

    @Test
    fun mapTokenSetsCorrectInputField() {
        val files = generateFiles(buildMapTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(
            paginator.contains("self.params.exclusive_start_key = self.next_token"),
            "Should set exclusive_start_key from next_token",
        )
    }

    @Test
    fun mapTokenReadsCorrectOutputField() {
        val files = generateFiles(buildMapTokenModel())
        val paginator = files["paginator.zig"]!!
        assertTrue(
            paginator.contains("output.last_evaluated_key"),
            "Should read last_evaluated_key from output",
        )
    }
}

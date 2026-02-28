package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.MapShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.ErrorTrait
import software.amazon.smithy.model.traits.RequiredTrait
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigSymbolVisitor
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.aws.protocols.AwsJsonProtocol
import software.amazon.smithy.zig.generators.ServiceGenerator
import java.nio.file.Path

class AwsJsonProtocolTest {

    @TempDir
    lateinit var tempDir: Path

    private fun buildTestModel(): Model {
        return Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#ResourceNotFoundException")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#AttributeValue")
                    .addMember("S", ShapeId.from("smithy.api#String"))
                    .addMember("N", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                MapShape.builder()
                    .id("test#AttributeMap")
                    .key(ShapeId.from("smithy.api#String"))
                    .value(ShapeId.from("test#AttributeValue"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#PutItemInput")
                    .addMember("TableName", ShapeId.from("smithy.api#String"))
                    .addMember("ItemCount", ShapeId.from("smithy.api#Integer"))
                    .addMember("Item", ShapeId.from("test#AttributeMap"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#PutItemOutput")
                    .addMember("ConsumedCapacity", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#PutItem")
                    .input(ShapeId.from("test#PutItemInput"))
                    .output(ShapeId.from("test#PutItemOutput"))
                    .addError(ShapeId.from("test#ResourceNotFoundException"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#ListTablesInput")
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#ListTablesOutput")
                    .addMember("TableCount", ShapeId.from("smithy.api#Integer"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#ListTables")
                    .input(ShapeId.from("test#ListTablesInput"))
                    .output(ShapeId.from("test#ListTablesOutput"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#GetItemInput")
                    .addMember("TableName", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#GetItemOutput")
                    .addMember(
                        MemberShape.builder()
                            .id("test#GetItemOutput\$SequenceNumber")
                            .target("smithy.api#String")
                            .addTrait(RequiredTrait())
                            .build()
                    )
                    .addMember("ConsumedCapacity", ShapeId.from("smithy.api#String"))
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
                    .id("test#DynamoDB_20120810")
                    .version("2012-08-10")
                    .addOperation(ShapeId.from("test#PutItem"))
                    .addOperation(ShapeId.from("test#ListTables"))
                    .addOperation(ShapeId.from("test#GetItem"))
                    .build()
            )
            .assemble()
            .unwrap()
    }

    private fun createContext(model: Model): ZigContext {
        val settings = ZigSettings(
            ShapeId.from("test#DynamoDB_20120810"),
            "dynamodb",
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

    private fun generateFiles(version: String): Map<String, String> {
        val model = buildTestModel()
        val context = createContext(model)
        val service = model.expectShape(
            ShapeId.from("test#DynamoDB_20120810"),
            ServiceShape::class.java,
        )

        ServiceGenerator(context, service, model, AwsJsonProtocol(version)).run()
        context.writerDelegator().flushWriters()

        val files = mutableMapOf<String, String>()
        for (file in context.fileManifest().files) {
            files[file.fileName.toString()] = file.toFile().readText()
        }
        return files
    }

    // ---- Content-Type tests ----

    @Test
    fun contentTypeJson10() {
        val protocol = AwsJsonProtocol("1.0")
        assertTrue(
            protocol.contentType() == "application/x-amz-json-1.0",
            "AWS JSON 1.0 should use application/x-amz-json-1.0",
        )
    }

    @Test
    fun contentTypeJson11() {
        val protocol = AwsJsonProtocol("1.1")
        assertTrue(
            protocol.contentType() == "application/x-amz-json-1.1",
            "AWS JSON 1.1 should use application/x-amz-json-1.1",
        )
    }

    // ---- X-Amz-Target header tests ----

    @Test
    fun serializerSetsXAmzTargetHeader() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("X-Amz-Target"),
            "Missing X-Amz-Target header",
        )
        assertTrue(
            op.contains("DynamoDB_20120810.PutItem"),
            "X-Amz-Target should be ServiceName.OperationName",
        )
    }

    @Test
    fun serializerSetsContentType() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("application/x-amz-json-1.0"),
            "Missing JSON 1.0 content type in generated code",
        )
    }

    @Test
    fun json11UsesCorrectContentType() {
        val files = generateFiles("1.1")
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("application/x-amz-json-1.1"),
            "Missing JSON 1.1 content type in generated code",
        )
    }

    // ---- JSON serialization tests ----

    @Test
    fun serializerUsesRuntimeJsonStringify() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(op.contains("fn serializeRequest("), "Missing serializeRequest")
        assertTrue(
            op.contains("aws.json.jsonStringify(input, alloc)"),
            "Should use runtime JSON serializer",
        )
    }

    @Test
    fun emptyInputDiscardsInput() {
        val files = generateFiles("1.0")
        val op = files["list_tables.zig"]!!

        assertTrue(
            op.contains("_ = input;"),
            "Empty input should be discarded",
        )
    }

    @Test
    fun emptyInputUsesEmptyJson() {
        val files = generateFiles("1.0")
        val op = files["list_tables.zig"]!!

        assertTrue(
            op.contains("\"{}\""),
            "Empty input should use empty JSON object",
        )
    }

    // ---- Deserialization tests ----

    @Test
    fun deserializerUsesJsonParser() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(op.contains("fn deserializeResponse("), "Missing deserializeResponse")
        assertTrue(
            op.contains("aws.json.parseJsonObject(PutItemOutput, body, alloc)"),
            "Should use runtime JSON parser for response deserialization",
        )
    }

    @Test
    fun deserializeResponseAcceptsHeaders() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator)"),
            "deserializeResponse should accept headers parameter",
        )
        assertTrue(
            op.contains("_ = headers;"),
            "AWS JSON protocol should mark headers as unused",
        )
    }

    @Test
    fun deserializerUsesJsonParserForListTables() {
        val files = generateFiles("1.0")
        val op = files["list_tables.zig"]!!

        assertTrue(
            op.contains("aws.json.parseJsonObject(ListTablesOutput, body, alloc)"),
            "Should use runtime JSON parser for response deserialization",
        )
    }

    // ---- Error parsing tests ----

    @Test
    fun errorParserUsesUnderscoreType() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(op.contains("fn parseErrorResponse("), "Missing parseErrorResponse")
        assertTrue(
            op.contains("__type"),
            "Should extract error code from __type field",
        )
        assertTrue(op.contains("alloc: std.mem.Allocator"), "parseErrorResponse missing allocator parameter")
    }

    @Test
    fun errorParserStripsNamespacePrefix() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("lastIndexOfScalar"),
            "Should strip namespace prefix from __type using '#' delimiter",
        )
    }

    @Test
    fun errorParserMatchesErrorCodes() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("\"ResourceNotFoundException\""),
            "Missing error code matching",
        )
    }

    @Test
    fun errorParserChecksMessageAndMessageCase() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("\"message\""),
            "Should check lowercase 'message' field",
        )
        assertTrue(
            op.contains("\"Message\""),
            "Should check uppercase 'Message' field as fallback",
        )
    }

    @Test
    fun errorParserDoesNotUseXmlElements() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertFalse(
            op.contains("findElement"),
            "JSON protocol should NOT use XML findElement",
        )
        assertFalse(
            op.contains("<Code>"),
            "JSON protocol should NOT reference XML tags",
        )
    }

    // ---- Helper functions tests ----

    @Test
    fun helperFunctionsPresent() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(op.contains("aws.json.findJsonValue("), "Missing findJsonValue usage")
        assertTrue(op.contains("aws.url.parseHost("), "Missing parseHost usage")
        assertTrue(op.contains("aws.url.parsePort("), "Missing parsePort usage")
    }

    // ---- No XML helpers ----

    @Test
    fun noXmlHelpers() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertFalse(
            op.contains("fn findElement("),
            "JSON protocol should NOT include XML findElement helper",
        )
        assertFalse(
            op.contains("fn appendUrlEncoded("),
            "JSON protocol should NOT include URL encoding helper",
        )
    }

    // ---- Method is always POST, path is always / ----

    @Test
    fun requestIsPostToRoot() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(op.contains("request.method = .POST;"), "Method should be POST")
        assertTrue(op.contains("request.path = \"/\";"), "Path should be /")
    }

    // ---- File list test ----

    @Test
    fun allExpectedFilesGenerated() {
        val files = generateFiles("1.0")
        val expectedFiles = listOf(
            "errors.zig",
            "client.zig",
            "root.zig",
            "put_item.zig",
            "list_tables.zig",
        )
        for (expected in expectedFiles) {
            assertTrue(files.containsKey(expected), "Missing generated file: $expected")
        }
    }

    // ---- Map type tests ----

    @Test
    fun mapMemberImportsSharedType() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("const AttributeValue = @import(\"attribute_value.zig\").AttributeValue;"),
            "Operation with map member should import the map value type",
        )
    }

    // ---- Empty body shortcut tests ----

    @Test
    fun emptyBodyShortcutForAllOptionalOutput() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("if (body.len == 0) return .{};"),
            "All-optional output should have empty body shortcut",
        )
    }

    @Test
    fun noEmptyBodyShortcutForRequiredOutput() {
        val files = generateFiles("1.0")
        val op = files["get_item.zig"]!!

        assertNotNull(op, "get_item.zig should be generated")
        assertFalse(
            op.contains("if (body.len == 0) return .{};"),
            "Output with required fields should NOT have empty body shortcut",
        )
        assertTrue(
            op.contains("aws.json.parseJsonObject(GetItemOutput, body, alloc)"),
            "Should still use JSON parser",
        )
    }

    @Test
    fun mapMemberInStructUsesMapEntryType() {
        val files = generateFiles("1.0")
        // PutItemInput is an I/O shape, so it's in the operation file
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("aws.map.MapEntry(AttributeValue)"),
            "Map member in struct should use MapEntry type for non-string values",
        )
    }
}

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
import software.amazon.smithy.model.traits.DocumentationTrait
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

    private fun buildTestModel(version: String): Model {
        val protocolTrait = when (version) {
            "1.0" -> "awsJson1_0"
            "1.1" -> "awsJson1_1"
            else -> error("Unsupported AWS JSON version: $version")
        }

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
                    .id("test#ConditionalCheckFailedException")
                    .addTrait(ErrorTrait("client"))
                    .addTrait(DocumentationTrait("The condition on the request was not satisfied."))
                    .addMember(
                        MemberShape.builder()
                            .id("test#ConditionalCheckFailedException\$Message")
                            .target("smithy.api#String")
                            .addTrait(DocumentationTrait("A normalized explanation of the failure."))
                            .build()
                    )
                    .addMember("requestId", ShapeId.from("smithy.api#String"))
                    .addMember(
                        MemberShape.builder()
                            .id("test#ConditionalCheckFailedException\$Reason")
                            .target("test#ErrorReason")
                            .addTrait(RequiredTrait())
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#ConditionalCheckFailedException\$Item")
                            .target("test#AttributeMap")
                            .addTrait(DocumentationTrait("The item that caused the condition check to fail."))
                            .build()
                    )
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
                    .addError(ShapeId.from("test#ConditionalCheckFailedException"))
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
            .addUnparsedModel(
                "error-reason.smithy",
                """
                ${'$'}version: "2"
                namespace test

                enum ErrorReason {
                    CONDITION_FAILED
                }
                """.trimIndent(),
            )
            .addUnparsedModel(
                "aws-json-traits.smithy",
                """
                ${'$'}version: "2"
                namespace aws.protocols

                @trait(selector: "service")
                structure awsJson1_0 {}

                @trait(selector: "service")
                structure awsJson1_1 {}
                """.trimIndent(),
            )
            .addUnparsedModel(
                "service.smithy",
                """
                ${'$'}version: "2"
                namespace test

                use aws.protocols#$protocolTrait

                @$protocolTrait
                service DynamoDB_20120810 {
                    version: "2012-08-10"
                    operations: [PutItem, ListTables, GetItem]
                }
                """.trimIndent(),
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
        val model = buildTestModel(version)
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
            op.contains("aws.json.jsonStringify(input, allocator)"),
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
            op.contains("aws.json.parseJsonObject(PutItemOutput, body, allocator)"),
            "Should use runtime JSON parser for response deserialization",
        )
    }

    @Test
    fun deserializeResponseAcceptsHeaders() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!

        assertTrue(
            op.contains("fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype)"),
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
            op.contains("aws.json.parseJsonObject(ListTablesOutput, body, allocator)"),
            "Should use runtime JSON parser for response deserialization",
        )
    }

    // ---- Error parsing tests ----

    @Test
    fun errorParserUsesUnderscoreType() {
        val files = generateFiles("1.0")
        val errors = files["errors.zig"]!!

        assertTrue(errors.contains("fn parseErrorResponse("), "Missing parseErrorResponse")
        assertTrue(
            errors.contains("__type"),
            "Should extract error code from __type field",
        )
        assertTrue(errors.contains("allocator: std.mem.Allocator"), "parseErrorResponse missing allocator parameter")
    }

    @Test
    fun errorParserStripsNamespacePrefix() {
        val files = generateFiles("1.0")
        val errors = files["errors.zig"]!!

        assertTrue(
            errors.contains("findScalarLast"),
            "Should strip namespace prefix from __type using '#' delimiter",
        )
    }

    @Test
    fun errorParserMatchesErrorCodes() {
        val files = generateFiles("1.0")
        val errors = files["errors.zig"]!!

        assertTrue(
            errors.contains("\"ResourceNotFoundException\""),
            "Missing error code matching",
        )
    }

    @Test
    fun errorParserChecksMessageAndMessageCase() {
        val files = generateFiles("1.0")
        val errors = files["errors.zig"]!!

        assertTrue(
            errors.contains("\"message\""),
            "Should check lowercase 'message' field",
        )
        assertTrue(
            errors.contains("\"Message\""),
            "Should check uppercase 'Message' field as fallback",
        )
    }

    @Test
    fun errorParserDoesNotUseXmlElements() {
        val files = generateFiles("1.0")
        val errors = files["errors.zig"]!!

        assertFalse(
            errors.contains("findElement"),
            "JSON protocol should NOT use XML findElement",
        )
        assertFalse(
            errors.contains("<Code>"),
            "JSON protocol should NOT reference XML tags",
        )
    }

    @Test
    fun modeledErrorsIncludeMembersImportsDocsAndWireNames() {
        for (version in listOf("1.0", "1.1")) {
            val files = generateFiles(version)
            val errors = files["errors.zig"]!!
            val exception = errors
                .substringAfter("pub const ConditionalCheckFailedException = struct {")
                .substringBefore("\npub const ResourceNotFoundException")

            assertTrue(errors.contains("const aws = @import(\"aws\");"), "AWS JSON $version error maps should import aws")
            assertTrue(
                errors.contains("const AttributeValue = @import(\"attribute_value.zig\").AttributeValue;"),
                "AWS JSON $version errors should import map value types",
            )
            assertTrue(
                errors.contains("/// The condition on the request was not satisfied."),
                "AWS JSON $version errors should retain exception documentation",
            )
            assertTrue(
                exception.contains("/// The item that caused the condition check to fail."),
                "AWS JSON $version errors should retain member documentation",
            )
            assertTrue(
                exception.contains("item: ?[]const aws.map.MapEntry(AttributeValue) = null,"),
                "AWS JSON $version errors should use output-style map optionality",
            )
            assertTrue(exception.contains(".message = \"Message\","), "AWS JSON $version should preserve Message wire casing")
            assertTrue(exception.contains(".request_id = \"requestId\","), "AWS JSON $version should map reserved request IDs")
            assertTrue(exception.contains(".item = \"Item\","), "AWS JSON $version should map modeled member names")
            assertTrue(
                Regex("(?m)^    message: ").findAll(exception).count() == 1,
                "AWS JSON $version should not duplicate normalized message",
            )
            assertTrue(
                Regex("(?m)^    request_id: ").findAll(exception).count() == 1,
                "AWS JSON $version should not duplicate normalized request_id",
            )
        }
    }

    @Test
    fun requiredErrorEnumsAllowUnknownValues() {
        for (version in listOf("1.0", "1.1")) {
            val errors = generateFiles(version)["errors.zig"]!!
            assertTrue(
                errors.contains("reason: ?ErrorReason = null,"),
                "AWS JSON $version unknown error enum values should remain optional",
            )
        }
    }

    @Test
    fun modeledErrorParserDispatchesAndFallsBackWithoutSwallowingOom() {
        for (version in listOf("1.0", "1.1")) {
            val files = generateFiles(version)
            val op = files["put_item.zig"]!!
            val errors = files["errors.zig"]!!

            assertTrue(
                op.contains("const parseErrorResponse = @import(\"errors.zig\").parseErrorResponse;"),
                "AWS JSON $version should import the shared parser",
            )
            assertTrue(
                errors.contains("aws.json.parseJsonObject(ConditionalCheckFailedException, body, arena_alloc)"),
                "AWS JSON $version should deserialize recognized error bodies",
            )
            assertTrue(errors.contains("typed_error.message = owned_message;"), "AWS JSON $version should normalize error messages")
            assertTrue(errors.contains("typed_error.request_id = owned_request_id;"), "AWS JSON $version should normalize request IDs")
            assertTrue(errors.contains("else => null,"), "AWS JSON $version malformed typed bodies should fall through")
            assertTrue(errors.contains(".code = owned_code,"), "AWS JSON $version fallback should preserve the error code")
            assertTrue(errors.contains(".message = owned_message,"), "AWS JSON $version fallback should preserve the message")
            assertTrue(errors.contains(".http_status = status,"), "AWS JSON $version fallback should preserve HTTP status")
            assertTrue(
                errors.contains("error.OutOfMemory => return error.OutOfMemory,"),
                "AWS JSON $version typed parsing should propagate allocation failures",
            )
            assertTrue(
                op.contains("d.* = try parseErrorResponse(client.allocator, response.body, response.status);"),
                "AWS JSON $version operations should propagate diagnostic allocation failures",
            )
        }
    }

    // ---- Helper functions tests ----

    @Test
    fun helperFunctionsPresent() {
        val files = generateFiles("1.0")
        val op = files["put_item.zig"]!!
        val errors = files["errors.zig"]!!

        assertTrue(errors.contains("aws.json.findJsonValue("), "Missing findJsonValue usage")
        assertTrue(op.contains("aws.url.parseEndpoint("), "Missing parseEndpoint usage")
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
            op.contains("aws.json.parseJsonObject(GetItemOutput, body, allocator)"),
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

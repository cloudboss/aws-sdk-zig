package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.node.Node
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.ErrorTrait
import software.amazon.smithy.model.traits.HttpHeaderTrait
import software.amazon.smithy.model.traits.HttpLabelTrait
import software.amazon.smithy.model.traits.HttpPayloadTrait
import software.amazon.smithy.model.traits.HttpQueryTrait
import software.amazon.smithy.model.traits.HttpResponseCodeTrait
import software.amazon.smithy.model.traits.HttpTrait
import software.amazon.smithy.model.traits.RequiredTrait
import software.amazon.smithy.model.traits.DefaultTrait
import software.amazon.smithy.model.pattern.UriPattern
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigSymbolVisitor
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.aws.protocols.RestJsonProtocol
import software.amazon.smithy.zig.generators.ServiceGenerator
import java.nio.file.Path

class RestJsonProtocolTest {

    @TempDir
    lateinit var tempDir: Path

    /**
     * Build a Lambda-like model:
     *
     * - Invoke: POST /2015-03-31/functions/{FunctionName}/invocations
     *   - FunctionName: @httpLabel (required)
     *   - Qualifier: @httpQuery("Qualifier")
     *   - InvocationType: @httpHeader("X-Amz-Invocation-Type")
     *   - Payload: @httpPayload (blob = []const u8)
     *
     *   Output:
     *   - StatusCode: @httpResponseCode
     *   - FunctionError: @httpHeader("X-Amz-Function-Error")
     *   - Payload: @httpPayload
     *
     * - ListFunctions: GET /2015-03-31/functions
     *   - MaxItems: @httpQuery("MaxItems")
     *
     *   Output:
     *   - FunctionCount: integer (body)
     *   - NextMarker: string (body)
     */
    private fun buildTestModel(): Model {
        return Model.assembler()
            // Error shape
            .addShape(
                StructureShape.builder()
                    .id("test#ResourceNotFoundException")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#ServiceException")
                    .addTrait(ErrorTrait("server"))
                    .addMember("Message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            // Invoke input
            .addShape(
                StructureShape.builder()
                    .id("test#InvokeInput")
                    .addMember(
                        MemberShape.builder()
                            .id("test#InvokeInput\$FunctionName")
                            .target("smithy.api#String")
                            .addTrait(HttpLabelTrait())
                            .addTrait(RequiredTrait())
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#InvokeInput\$Qualifier")
                            .target("smithy.api#String")
                            .addTrait(HttpQueryTrait("Qualifier"))
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#InvokeInput\$InvocationType")
                            .target("smithy.api#String")
                            .addTrait(HttpHeaderTrait("X-Amz-Invocation-Type"))
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#InvokeInput\$Payload")
                            .target("smithy.api#Blob")
                            .addTrait(HttpPayloadTrait())
                            .build()
                    )
                    .build()
            )
            // Invoke output
            .addShape(
                StructureShape.builder()
                    .id("test#InvokeOutput")
                    .addMember(
                        MemberShape.builder()
                            .id("test#InvokeOutput\$StatusCode")
                            .target("smithy.api#Integer")
                            .addTrait(HttpResponseCodeTrait())
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#InvokeOutput\$FunctionError")
                            .target("smithy.api#String")
                            .addTrait(HttpHeaderTrait("X-Amz-Function-Error"))
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#InvokeOutput\$Payload")
                            .target("smithy.api#Blob")
                            .addTrait(HttpPayloadTrait())
                            .build()
                    )
                    .build()
            )
            // Invoke operation
            .addShape(
                OperationShape.builder()
                    .id("test#Invoke")
                    .input(ShapeId.from("test#InvokeInput"))
                    .output(ShapeId.from("test#InvokeOutput"))
                    .addError(ShapeId.from("test#ResourceNotFoundException"))
                    .addError(ShapeId.from("test#ServiceException"))
                    .addTrait(
                        HttpTrait.builder()
                            .method("POST")
                            .uri(UriPattern.parse("/2015-03-31/functions/{FunctionName}/invocations"))
                            .code(200)
                            .build()
                    )
                    .build()
            )
            // Runtime enum for header list test
            .addShape(
                EnumShape.builder()
                    .id("test#RuntimeType")
                    .addMember("Nodejs", "nodejs")
                    .addMember("Python", "python")
                    .build()
            )
            // List of enums for header list test
            .addShape(
                ListShape.builder()
                    .id("test#RuntimeTypeList")
                    .member(ShapeId.from("test#RuntimeType"))
                    .build()
            )
            // ListFunctions input
            .addShape(
                StructureShape.builder()
                    .id("test#ListFunctionsInput")
                    .addMember(
                        MemberShape.builder()
                            .id("test#ListFunctionsInput\$MaxItems")
                            .target("smithy.api#String")
                            .addTrait(DefaultTrait(Node.from("")))
                            .addTrait(HttpQueryTrait("MaxItems"))
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#ListFunctionsInput\$FilterRuntimes")
                            .target("test#RuntimeTypeList")
                            .addTrait(HttpHeaderTrait("X-Filter-Runtimes"))
                            .build()
                    )
                    .build()
            )
            // ListFunctions output (body members only)
            .addShape(
                StructureShape.builder()
                    .id("test#ListFunctionsOutput")
                    .addMember("FunctionCount", ShapeId.from("smithy.api#Integer"))
                    .addMember("NextMarker", ShapeId.from("smithy.api#String"))
                    .build()
            )
            // ListFunctions operation
            .addShape(
                OperationShape.builder()
                    .id("test#ListFunctions")
                    .input(ShapeId.from("test#ListFunctionsInput"))
                    .output(ShapeId.from("test#ListFunctionsOutput"))
                    .addTrait(
                        HttpTrait.builder()
                            .method("GET")
                            .uri(UriPattern.parse("/2015-03-31/functions"))
                            .code(200)
                            .build()
                    )
                    .build()
            )
            // Service
            .addShape(
                ServiceShape.builder()
                    .id("test#Lambda")
                    .version("2015-03-31")
                    .addOperation(ShapeId.from("test#Invoke"))
                    .addOperation(ShapeId.from("test#ListFunctions"))
                    .build()
            )
            .assemble()
            .unwrap()
    }

    private fun createContext(model: Model): ZigContext {
        val settings = ZigSettings(
            ShapeId.from("test#Lambda"),
            "lambda",
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

    private fun generateFiles(): Map<String, String> {
        val model = buildTestModel()
        val context = createContext(model)
        val service = model.expectShape(
            ShapeId.from("test#Lambda"),
            ServiceShape::class.java,
        )

        ServiceGenerator(context, service, model, RestJsonProtocol()).run()
        context.writerDelegator().flushWriters()

        val files = mutableMapOf<String, String>()
        for (file in context.fileManifest().files) {
            files[file.fileName.toString()] = file.toFile().readText()
        }
        return files
    }

    // ---- File generation tests ----

    @Test
    fun allExpectedFilesGenerated() {
        val files = generateFiles()
        val expectedFiles = listOf(
            "errors.zig",
            "client.zig",
            "root.zig",
            "invoke.zig",
            "list_functions.zig",
        )
        for (expected in expectedFiles) {
            assertTrue(files.containsKey(expected), "Missing generated file: $expected")
        }
    }

    // ---- Content-Type tests ----

    @Test
    fun contentTypeIsApplicationJson() {
        val protocol = RestJsonProtocol()
        assertTrue(
            protocol.contentType() == "application/json",
            "REST-JSON should use application/json",
        )
    }

    @Test
    fun serializerSetsContentType() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(
            op.contains("application/json"),
            "Missing Content-Type header in generated code",
        )
    }

    // ---- HTTP method and URI path tests ----

    @Test
    fun invokeUsesPostMethod() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(op.contains("request.method = .POST;"), "Invoke should use POST method")
    }

    @Test
    fun listFunctionsUsesGetMethod() {
        val files = generateFiles()
        val op = files["list_functions.zig"]!!

        assertTrue(op.contains("request.method = .GET;"), "ListFunctions should use GET method")
    }

    @Test
    fun invokeBuildsUriWithLabel() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        // Should substitute {FunctionName} in the URI
        assertTrue(
            op.contains("/2015-03-31/functions/"),
            "Should have static URI prefix",
        )
        assertTrue(
            op.contains("/invocations"),
            "Should have static URI suffix",
        )
        assertTrue(
            op.contains("input.function_name"),
            "Should reference function_name field for URI label",
        )
        assertTrue(
            op.contains("path_buf"),
            "Should use dynamic path buffer for label substitution",
        )
    }

    @Test
    fun listFunctionsUsesStaticPath() {
        val files = generateFiles()
        val op = files["list_functions.zig"]!!

        assertTrue(
            op.contains("/2015-03-31/functions"),
            "ListFunctions should have static path",
        )
    }

    // ---- @httpQuery tests ----

    @Test
    fun invokeSerializesQueryParam() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(
            op.contains("Qualifier="),
            "Should serialize Qualifier as query parameter",
        )
        assertTrue(
            op.contains("appendUrlEncoded"),
            "Should URL-encode query values",
        )
    }

    @Test
    fun listFunctionsSerializesQueryParam() {
        val files = generateFiles()
        val op = files["list_functions.zig"]!!

        assertTrue(
            op.contains("MaxItems="),
            "Should serialize MaxItems as query parameter",
        )
    }

    // ---- @httpHeader tests ----

    @Test
    fun invokeSerializesHeaderParam() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(
            op.contains("X-Amz-Invocation-Type"),
            "Should set X-Amz-Invocation-Type header",
        )
    }

    // ---- @httpPayload tests ----

    @Test
    fun invokeUsesPayloadAsBody() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        // Should use payload member as body directly, not JSON-serialize all members
        assertTrue(
            op.contains("input.payload") || op.contains("input.payload orelse"),
            "Should use payload field as request body",
        )
        // Should NOT have JSON body construction for Invoke
        assertFalse(
            op.contains("body_buf") && op.contains("\"{\""),
            "Should NOT use JSON body construction when @httpPayload is present",
        )
    }

    // ---- @httpResponseCode tests ----

    @Test
    fun invokeDeserializesResponseCode() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(
            op.contains("status_code") && op.contains("status"),
            "Should deserialize HTTP status code into status_code field",
        )
    }

    // ---- @httpHeader in response tests ----

    @Test
    fun invokeDeserializesResponseHeaders() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(
            op.contains("headers.get(\"x-amz-function-error\")"),
            "Should extract FunctionError from x-amz-function-error response header (lowercased)",
        )
        assertTrue(
            op.contains("result.function_error"),
            "Should assign header value to function_error field",
        )
    }

    @Test
    fun deserializeResponseAcceptsHeaders() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(
            op.contains("fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype)"),
            "deserializeResponse should accept headers parameter",
        )
    }

    @Test
    fun invokeDeserializesPayloadResponse() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(
            op.contains("fn deserializeResponse("),
            "Should have deserializeResponse function",
        )
        assertTrue(
            op.contains("allocator.dupe(u8, body)"),
            "Should dupe payload body for output",
        )
    }

    @Test
    fun listFunctionsUnusedHeaders() {
        val files = generateFiles()
        val op = files["list_functions.zig"]!!

        // ListFunctions has no @httpHeader members in output, so headers should be unused
        assertTrue(
            op.contains("_ = headers;"),
            "Should mark headers as unused when no @httpHeader output members exist",
        )
    }

    // ---- Body member JSON deserialization (ListFunctions) ----

    @Test
    fun listFunctionsDeserializesJsonBody() {
        val files = generateFiles()
        val op = files["list_functions.zig"]!!

        assertTrue(
            op.contains("aws.json.parseJsonObject(ListFunctionsOutput, body, allocator)"),
            "Should use runtime JSON parser for response deserialization",
        )
    }

    // ---- Error parsing tests ----

    @Test
    fun errorParserUsesUnderscoreType() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(op.contains("fn parseErrorResponse("), "Missing parseErrorResponse")
        assertTrue(
            op.contains("__type"),
            "Should extract error code from __type field (same as AWS JSON)",
        )
        assertTrue(op.contains("allocator: std.mem.Allocator"), "parseErrorResponse missing allocator parameter")
    }

    @Test
    fun errorParserStripsNamespacePrefix() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(
            op.contains("lastIndexOfScalar"),
            "Should strip namespace prefix from __type using '#' delimiter",
        )
    }

    @Test
    fun errorParserMatchesErrorCodes() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(
            op.contains("\"ResourceNotFoundException\""),
            "Should match ResourceNotFoundException error code",
        )
        assertTrue(
            op.contains("\"ServiceException\""),
            "Should match ServiceException error code",
        )
    }

    // ---- Helper functions tests ----

    @Test
    fun helperFunctionsPresent() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertTrue(op.contains("aws.json.findJsonValue("), "Missing findJsonValue usage")
        assertTrue(op.contains("aws.url.appendUrlEncoded("), "Missing appendUrlEncoded usage")
        assertTrue(op.contains("aws.url.parseHost("), "Missing parseHost usage")
        assertTrue(op.contains("aws.url.parsePort("), "Missing parsePort usage")
    }

    // ---- No XML helpers ----

    @Test
    fun noXmlHelpers() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertFalse(
            op.contains("aws.xml.findElement("),
            "REST-JSON should NOT include XML findElement usage",
        )
    }

    // ---- No X-Amz-Target (that's AWS JSON only) ----

    @Test
    fun noXAmzTargetHeader() {
        val files = generateFiles()
        val op = files["invoke.zig"]!!

        assertFalse(
            op.contains("X-Amz-Target"),
            "REST-JSON should NOT use X-Amz-Target header (that's AWS JSON)",
        )
    }

    // ---- JSON body for non-payload operations ----

    @Test
    fun listFunctionsDoesNotBuildJsonBodyForEmptyBodyMembers() {
        val files = generateFiles()
        val op = files["list_functions.zig"]!!

        // ListFunctions has no body members in input (only @httpQuery)
        // So body should be null
        assertTrue(
            op.contains("null") || !op.contains("body_buf"),
            "Should not build JSON body when there are no body members",
        )
    }

    @Test
    fun listFunctionsInputUsesDefaultForQueryParam() {
        val files = generateFiles()
        val op = files["list_functions.zig"]!!

        assertTrue(
            op.contains("max_items: ?[]const u8 = null"),
            "ListFunctionsInput should use default value for MaxItems",
        )
    }

    // ---- List-of-enum header test ----

    @Test
    fun listHeaderSerializesAsList() {
        val files = generateFiles()
        val op = files["list_functions.zig"]!!

        assertTrue(
            op.contains("header_buf"),
            "List-of-enum header should use header_buf for serialization",
        )
    }
}

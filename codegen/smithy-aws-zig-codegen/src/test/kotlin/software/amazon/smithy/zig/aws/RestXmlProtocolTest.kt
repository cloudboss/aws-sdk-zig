package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
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
import software.amazon.smithy.model.traits.HttpHeaderTrait
import software.amazon.smithy.model.traits.HttpLabelTrait
import software.amazon.smithy.model.traits.HttpPayloadTrait
import software.amazon.smithy.model.traits.HttpQueryTrait
import software.amazon.smithy.model.traits.HttpResponseCodeTrait
import software.amazon.smithy.model.traits.HttpTrait
import software.amazon.smithy.model.traits.RequiredTrait
import software.amazon.smithy.model.traits.XmlNameTrait
import software.amazon.smithy.model.pattern.UriPattern
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigSymbolVisitor
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.aws.protocols.RestXmlProtocol
import software.amazon.smithy.zig.generators.ServiceGenerator
import java.nio.file.Path

class RestXmlProtocolTest {

    @TempDir
    lateinit var tempDir: Path

    /**
     * Build an S3-like model:
     *
     * - PutObject: PUT /buckets/{Bucket}/{Key}
     *   Input: Bucket @httpLabel (required), Key @httpLabel (required),
     *          ContentHash @httpHeader("x-amz-content-sha256"),
     *          Body @httpPayload (blob)
     *   Output: ETag @httpHeader("ETag")
     *
     * - ListObjects: GET /buckets/{Bucket}
     *   Input: Bucket @httpLabel (required), Prefix @httpQuery("prefix")
     *   Output: Name (string body), KeyCount (integer body), IsTruncated (boolean body)
     *
     * - DeleteObject: DELETE /buckets/{Bucket}/{Key}
     *   Input: Bucket @httpLabel (required), Key @httpLabel (required),
     *          VersionId @httpQuery("versionId")
     *   Output: StatusCode @httpResponseCode
     *
     * - CreateConfig: POST /configs
     *   Input: Region (string body), Enabled (boolean body)
     *   Output: ConfigId (string body)
     */
    private fun buildTestModel(): Model {
        return Model.assembler()
            // Error shapes
            .addShape(
                StructureShape.builder()
                    .id("test#NoSuchBucketException")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#NoSuchKeyException")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            // PutObject input
            .addShape(
                StructureShape.builder()
                    .id("test#PutObjectInput")
                    .addMember(
                        MemberShape.builder()
                            .id("test#PutObjectInput\$Bucket")
                            .target("smithy.api#String")
                            .addTrait(HttpLabelTrait())
                            .addTrait(RequiredTrait())
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#PutObjectInput\$Key")
                            .target("smithy.api#String")
                            .addTrait(HttpLabelTrait())
                            .addTrait(RequiredTrait())
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#PutObjectInput\$ContentHash")
                            .target("smithy.api#String")
                            .addTrait(HttpHeaderTrait("x-amz-content-sha256"))
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#PutObjectInput\$Body")
                            .target("smithy.api#Blob")
                            .addTrait(HttpPayloadTrait())
                            .build()
                    )
                    .build()
            )
            // PutObject output
            .addShape(
                StructureShape.builder()
                    .id("test#PutObjectOutput")
                    .addMember(
                        MemberShape.builder()
                            .id("test#PutObjectOutput\$ETag")
                            .target("smithy.api#String")
                            .addTrait(HttpHeaderTrait("ETag"))
                            .build()
                    )
                    .build()
            )
            // PutObject operation
            .addShape(
                OperationShape.builder()
                    .id("test#PutObject")
                    .input(ShapeId.from("test#PutObjectInput"))
                    .output(ShapeId.from("test#PutObjectOutput"))
                    .addError(ShapeId.from("test#NoSuchBucketException"))
                    .addTrait(
                        HttpTrait.builder()
                            .method("PUT")
                            .uri(UriPattern.parse("/buckets/{Bucket}/{Key}"))
                            .code(200)
                            .build()
                    )
                    .build()
            )
            // ListObjects input
            .addShape(
                StructureShape.builder()
                    .id("test#ListObjectsInput")
                    .addMember(
                        MemberShape.builder()
                            .id("test#ListObjectsInput\$Bucket")
                            .target("smithy.api#String")
                            .addTrait(HttpLabelTrait())
                            .addTrait(RequiredTrait())
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#ListObjectsInput\$Prefix")
                            .target("smithy.api#String")
                            .addTrait(HttpQueryTrait("prefix"))
                            .build()
                    )
                    .build()
            )
            // ListObjects output (XML body members with @xmlName)
            .addShape(
                StructureShape.builder()
                    .id("test#ListObjectsOutput")
                    .addMember(
                        MemberShape.builder()
                            .id("test#ListObjectsOutput\$Name")
                            .target("smithy.api#String")
                            .addTrait(XmlNameTrait("Name"))
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#ListObjectsOutput\$KeyCount")
                            .target("smithy.api#Integer")
                            .addTrait(XmlNameTrait("KeyCount"))
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#ListObjectsOutput\$IsTruncated")
                            .target("smithy.api#Boolean")
                            .addTrait(XmlNameTrait("IsTruncated"))
                            .build()
                    )
                    .build()
            )
            // ListObjects operation
            .addShape(
                OperationShape.builder()
                    .id("test#ListObjects")
                    .input(ShapeId.from("test#ListObjectsInput"))
                    .output(ShapeId.from("test#ListObjectsOutput"))
                    .addTrait(
                        HttpTrait.builder()
                            .method("GET")
                            .uri(UriPattern.parse("/buckets/{Bucket}"))
                            .code(200)
                            .build()
                    )
                    .build()
            )
            // DeleteObject input
            .addShape(
                StructureShape.builder()
                    .id("test#DeleteObjectInput")
                    .addMember(
                        MemberShape.builder()
                            .id("test#DeleteObjectInput\$Bucket")
                            .target("smithy.api#String")
                            .addTrait(HttpLabelTrait())
                            .addTrait(RequiredTrait())
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#DeleteObjectInput\$Key")
                            .target("smithy.api#String")
                            .addTrait(HttpLabelTrait())
                            .addTrait(RequiredTrait())
                            .build()
                    )
                    .addMember(
                        MemberShape.builder()
                            .id("test#DeleteObjectInput\$VersionId")
                            .target("smithy.api#String")
                            .addTrait(HttpQueryTrait("versionId"))
                            .build()
                    )
                    .build()
            )
            // DeleteObject output
            .addShape(
                StructureShape.builder()
                    .id("test#DeleteObjectOutput")
                    .addMember(
                        MemberShape.builder()
                            .id("test#DeleteObjectOutput\$StatusCode")
                            .target("smithy.api#Integer")
                            .addTrait(HttpResponseCodeTrait())
                            .build()
                    )
                    .build()
            )
            // DeleteObject operation
            .addShape(
                OperationShape.builder()
                    .id("test#DeleteObject")
                    .input(ShapeId.from("test#DeleteObjectInput"))
                    .output(ShapeId.from("test#DeleteObjectOutput"))
                    .addError(ShapeId.from("test#NoSuchKeyException"))
                    .addTrait(
                        HttpTrait.builder()
                            .method("DELETE")
                            .uri(UriPattern.parse("/buckets/{Bucket}/{Key}"))
                            .code(204)
                            .build()
                    )
                    .build()
            )
            // String map for tags
            .addShape(
                MapShape.builder()
                    .id("test#StringMap")
                    .key(ShapeId.from("smithy.api#String"))
                    .value(ShapeId.from("smithy.api#String"))
                    .build()
            )
            // CreateConfig input (XML body members)
            .addShape(
                StructureShape.builder()
                    .id("test#CreateConfigInput")
                    .addMember("Region", ShapeId.from("smithy.api#String"))
                    .addMember("Enabled", ShapeId.from("smithy.api#Boolean"))
                    .addMember("Tags", ShapeId.from("test#StringMap"))
                    .build()
            )
            // CreateConfig output
            .addShape(
                StructureShape.builder()
                    .id("test#CreateConfigOutput")
                    .addMember("ConfigId", ShapeId.from("smithy.api#String"))
                    .build()
            )
            // CreateConfig operation
            .addShape(
                OperationShape.builder()
                    .id("test#CreateConfig")
                    .input(ShapeId.from("test#CreateConfigInput"))
                    .output(ShapeId.from("test#CreateConfigOutput"))
                    .addTrait(
                        HttpTrait.builder()
                            .method("POST")
                            .uri(UriPattern.parse("/configs"))
                            .code(200)
                            .build()
                    )
                    .build()
            )
            // Service
            .addShape(
                ServiceShape.builder()
                    .id("test#Storage")
                    .version("2006-03-01")
                    .addOperation(ShapeId.from("test#PutObject"))
                    .addOperation(ShapeId.from("test#ListObjects"))
                    .addOperation(ShapeId.from("test#DeleteObject"))
                    .addOperation(ShapeId.from("test#CreateConfig"))
                    .build()
            )
            .assemble()
            .unwrap()
    }

    private fun createContext(model: Model): ZigContext {
        val settings = ZigSettings(
            ShapeId.from("test#Storage"),
            "storage",
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
            ShapeId.from("test#Storage"),
            ServiceShape::class.java,
        )

        ServiceGenerator(context, service, model, RestXmlProtocol()).run()
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
            "put_object.zig",
            "list_objects.zig",
            "delete_object.zig",
            "create_config.zig",
        )
        for (expected in expectedFiles) {
            assertTrue(files.containsKey(expected), "Missing generated file: $expected")
        }
    }

    // ---- Content-Type tests ----

    @Test
    fun contentTypeIsApplicationXml() {
        val protocol = RestXmlProtocol()
        assertTrue(
            protocol.contentType() == "application/xml",
            "REST-XML should use application/xml",
        )
    }

    @Test
    fun serializerSetsContentType() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!

        assertTrue(
            op.contains("application/xml"),
            "Missing Content-Type header in generated code",
        )
    }

    // ---- HTTP method and URI path tests ----

    @Test
    fun putObjectUsesPutMethod() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!
        assertTrue(op.contains("request.method = .PUT;"), "PutObject should use PUT method")
    }

    @Test
    fun listObjectsUsesGetMethod() {
        val files = generateFiles()
        val op = files["list_objects.zig"]!!
        assertTrue(op.contains("request.method = .GET;"), "ListObjects should use GET method")
    }

    @Test
    fun deleteObjectUsesDeleteMethod() {
        val files = generateFiles()
        val op = files["delete_object.zig"]!!
        assertTrue(op.contains("request.method = .DELETE;"), "DeleteObject should use DELETE method")
    }

    @Test
    fun createConfigUsesPostMethod() {
        val files = generateFiles()
        val op = files["create_config.zig"]!!
        assertTrue(op.contains("request.method = .POST;"), "CreateConfig should use POST method")
    }

    @Test
    fun putObjectBuildsUriWithLabels() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!

        assertTrue(op.contains("/buckets/"), "Should have static URI prefix")
        assertTrue(op.contains("input.bucket"), "Should reference bucket field for URI label")
        assertTrue(op.contains("input.key"), "Should reference key field for URI label")
        assertTrue(op.contains("path_buf"), "Should use dynamic path buffer for label substitution")
    }

    @Test
    fun listObjectsBuildsUriWithLabel() {
        val files = generateFiles()
        val op = files["list_objects.zig"]!!

        assertTrue(op.contains("/buckets/"), "Should have static URI prefix")
        assertTrue(op.contains("input.bucket"), "Should reference bucket field")
    }

    // ---- @httpQuery tests ----

    @Test
    fun listObjectsSerializesQueryParam() {
        val files = generateFiles()
        val op = files["list_objects.zig"]!!

        assertTrue(op.contains("prefix="), "Should serialize prefix as query parameter")
        assertTrue(op.contains("appendUrlEncoded"), "Should URL-encode query values")
    }

    @Test
    fun deleteObjectSerializesQueryParam() {
        val files = generateFiles()
        val op = files["delete_object.zig"]!!

        assertTrue(op.contains("versionId="), "Should serialize versionId as query parameter")
    }

    // ---- @httpHeader tests ----

    @Test
    fun putObjectSetsHeaderParam() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!

        assertTrue(
            op.contains("x-amz-content-sha256"),
            "Should set x-amz-content-sha256 header",
        )
    }

    // ---- @httpPayload tests ----

    @Test
    fun putObjectUsesPayloadAsBody() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!

        assertTrue(
            op.contains("input.body") || op.contains("input.body orelse"),
            "Should use body field as request body",
        )
        assertFalse(
            op.contains("body_buf") && op.contains("<PutObjectInput>"),
            "Should NOT use XML body construction when @httpPayload is present",
        )
    }

    // ---- @httpHeader in response tests ----

    @Test
    fun putObjectDeserializesResponseHeaders() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!

        assertTrue(
            op.contains("headers.get(\"etag\")"),
            "Should extract ETag from response header (lowercased)",
        )
        assertTrue(
            op.contains("result.e_tag"),
            "Should assign header value to e_tag field",
        )
    }

    @Test
    fun deserializeResponseAcceptsHeaders() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!

        assertTrue(
            op.contains("fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator)"),
            "deserializeResponse should accept headers parameter",
        )
    }

    @Test
    fun listObjectsUnusedHeaders() {
        val files = generateFiles()
        val op = files["list_objects.zig"]!!

        // ListObjects has no @httpHeader members in output, so headers should be unused
        assertTrue(
            op.contains("_ = headers;"),
            "Should mark headers as unused when no @httpHeader output members exist",
        )
    }

    // ---- @httpResponseCode tests ----

    @Test
    fun deleteObjectDeserializesResponseCode() {
        val files = generateFiles()
        val op = files["delete_object.zig"]!!

        assertTrue(
            op.contains("status_code") && op.contains("status"),
            "Should deserialize HTTP status code into status_code field",
        )
    }

    @Test
    fun deleteObjectUnusedBody() {
        val files = generateFiles()
        val op = files["delete_object.zig"]!!

        assertTrue(
            op.contains("_ = body;"),
            "Should mark body as unused when only @httpResponseCode is used",
        )
    }

    // ---- XML body serialization tests (CreateConfig) ----

    @Test
    fun createConfigSerializesXmlBody() {
        val files = generateFiles()
        val op = files["create_config.zig"]!!

        assertTrue(
            op.contains("<CreateConfigInput>"),
            "Should have XML root element matching input shape name",
        )
        assertTrue(
            op.contains("</CreateConfigInput>"),
            "Should close XML root element",
        )
    }

    @Test
    fun createConfigSerializesStringMember() {
        val files = generateFiles()
        val op = files["create_config.zig"]!!

        assertTrue(
            op.contains("<Region>"),
            "Should serialize Region as XML element",
        )
        assertTrue(
            op.contains("</Region>"),
            "Should close Region XML element",
        )
        assertTrue(
            op.contains("appendXmlEscaped"),
            "Should XML-escape string values",
        )
    }

    @Test
    fun createConfigSerializesBooleanMember() {
        val files = generateFiles()
        val op = files["create_config.zig"]!!

        assertTrue(
            op.contains("<Enabled>"),
            "Should serialize Enabled as XML element",
        )
        assertTrue(
            op.contains("\"true\"") && op.contains("\"false\""),
            "Should serialize boolean as true/false strings",
        )
    }

    // ---- XML body deserialization tests (ListObjects) ----

    @Test
    fun listObjectsDeserializesXmlBody() {
        val files = generateFiles()
        val op = files["list_objects.zig"]!!

        assertTrue(
            op.contains("aws.xml.Reader.init(body)"),
            "Should create xml.Reader from body",
        )
        assertTrue(
            op.contains("e.local, \"Name\""),
            "Should match Name element in XML",
        )
        assertTrue(
            op.contains("e.local, \"KeyCount\""),
            "Should match KeyCount element in XML",
        )
        assertTrue(
            op.contains("e.local, \"IsTruncated\""),
            "Should match IsTruncated element in XML",
        )
    }

    @Test
    fun listObjectsDeserializesIntegers() {
        val files = generateFiles()
        val op = files["list_objects.zig"]!!

        assertTrue(
            op.contains("parseInt"),
            "Should parse integer from XML element content",
        )
    }

    @Test
    fun listObjectsDeserializesBooleans() {
        val files = generateFiles()
        val op = files["list_objects.zig"]!!

        assertTrue(
            op.contains("std.mem.eql(u8, try reader.readElementText(), \"true\")"),
            "Should compare boolean XML element text to 'true'",
        )
    }

    @Test
    fun listObjectsDeserializesStrings() {
        val files = generateFiles()
        val op = files["list_objects.zig"]!!

        assertTrue(
            op.contains("alloc.dupe(u8, try reader.readElementText())"),
            "Should dupe string element text for output",
        )
    }

    // ---- Error parsing tests ----

    @Test
    fun errorParserUsesXmlFormat() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!

        assertTrue(op.contains("fn parseErrorResponse("), "Missing parseErrorResponse")
        assertTrue(
            op.contains("aws.xml.findElement(body, \"Code\")"),
            "Should extract error code from XML <Code> element",
        )
        assertTrue(op.contains("alloc: std.mem.Allocator"), "parseErrorResponse missing allocator parameter")
        assertTrue(
            op.contains("aws.xml.findElement(body, \"Message\")"),
            "Should extract error message from XML <Message> element",
        )
        assertTrue(
            op.contains("aws.xml.findElement(body, \"RequestId\")"),
            "Should extract request ID from XML <RequestId> element",
        )
    }

    @Test
    fun errorParserMatchesErrorCodes() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!

        assertTrue(
            op.contains("\"NoSuchBucketException\""),
            "Should match NoSuchBucketException error code",
        )
    }

    @Test
    fun deleteObjectErrorParserMatchesCodes() {
        val files = generateFiles()
        val op = files["delete_object.zig"]!!

        assertTrue(
            op.contains("\"NoSuchKeyException\""),
            "Should match NoSuchKeyException error code",
        )
    }

    // ---- Helper functions tests ----

    @Test
    fun helperFunctionsPresent() {
        val files = generateFiles()

        // All operations use parseHost/parsePort for endpoint parsing
        val putObject = files["put_object.zig"]!!
        assertTrue(putObject.contains("aws.url.parseHost("), "Missing parseHost usage in put_object")
        assertTrue(putObject.contains("aws.url.parsePort("), "Missing parsePort usage in put_object")

        // Error parsing uses findElement for XML error responses
        assertTrue(putObject.contains("aws.xml.findElement("), "Missing findElement usage in put_object")

        // ListObjects has @httpQuery param so uses appendUrlEncoded
        val listObjects = files["list_objects.zig"]!!
        assertTrue(listObjects.contains("aws.url.appendUrlEncoded("), "Missing appendUrlEncoded usage in list_objects")

        // CreateConfig has XML body string members so uses appendXmlEscaped
        val createConfig = files["create_config.zig"]!!
        assertTrue(createConfig.contains("aws.xml.appendXmlEscaped("), "Missing appendXmlEscaped usage in create_config")
    }

    // ---- No JSON helpers (this is REST-XML) ----

    @Test
    fun noJsonHelpers() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!

        assertFalse(
            op.contains("aws.json.findJsonValue("),
            "REST-XML should NOT include JSON findJsonValue usage",
        )
        assertFalse(
            op.contains("fn appendJsonEscaped("),
            "REST-XML should NOT include JSON appendJsonEscaped helper",
        )
    }

    // ---- No X-Amz-Target (that's AWS JSON only) ----

    @Test
    fun noXAmzTargetHeader() {
        val files = generateFiles()
        val op = files["put_object.zig"]!!

        assertFalse(
            op.contains("X-Amz-Target"),
            "REST-XML should NOT use X-Amz-Target header",
        )
    }

    // ---- Empty body for non-payload GET operations ----

    @Test
    fun listObjectsHasNullBody() {
        val files = generateFiles()
        val op = files["list_objects.zig"]!!

        assertTrue(
            op.contains("null"),
            "ListObjects should have null body (GET with no body members in input)",
        )
    }

    // ---- CreateConfig output deserialization ----

    @Test
    fun createConfigDeserializesXmlOutput() {
        val files = generateFiles()
        val op = files["create_config.zig"]!!

        assertTrue(
            op.contains("e.local, \"ConfigId\""),
            "Should match ConfigId element in XML response body",
        )
    }

    // ---- Map field tests ----

    @Test
    fun mapFieldInXmlBodyCallsSerde() {
        val files = generateFiles()
        val op = files["create_config.zig"]!!

        assertTrue(
            op.contains("serde.serializeStringMap(") || op.contains("serde.deserializeStringMap("),
            "Map field should call serde map serializer or deserializer",
        )
    }

    @Test
    fun mapFieldImportsSerde() {
        val files = generateFiles()
        val op = files["create_config.zig"]!!

        assertTrue(
            op.contains("const serde = @import(\"serde.zig\");"),
            "Operation with map body member should import serde",
        )
    }
}

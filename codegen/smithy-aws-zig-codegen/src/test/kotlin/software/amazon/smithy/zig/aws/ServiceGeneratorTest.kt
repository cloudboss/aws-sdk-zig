package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.model.traits.ErrorTrait
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigSymbolVisitor
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.aws.protocols.AwsQueryProtocol
import software.amazon.smithy.zig.generators.ServiceGenerator
import java.nio.file.Path

class ServiceGeneratorTest {

    @TempDir
    lateinit var tempDir: Path

    private fun buildTestModel(): Model {
        return Model.assembler()
            // Shared structure type used in operation output
            .addShape(
                StructureShape.builder()
                    .id("test#Credentials")
                    .addMember("AccessKeyId", ShapeId.from("smithy.api#String"))
                    .addMember("SecretAccessKey", ShapeId.from("smithy.api#String"))
                    .build()
            )
            // Error shapes
            .addShape(
                StructureShape.builder()
                    .id("test#ExpiredTokenException")
                    .addTrait(ErrorTrait("client"))
                    .addTrait(DocumentationTrait("Token expired"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#InternalError")
                    .addTrait(ErrorTrait("server"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            // GetCallerIdentity operation (no input fields, simple output with shared type)
            .addShape(
                StructureShape.builder()
                    .id("test#GetCallerIdentityRequest")
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#GetCallerIdentityResponse")
                    .addMember("Account", ShapeId.from("smithy.api#String"))
                    .addMember("Arn", ShapeId.from("smithy.api#String"))
                    .addMember("UserId", ShapeId.from("smithy.api#String"))
                    .addMember("Credentials", ShapeId.from("test#Credentials"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#GetCallerIdentity")
                    .input(ShapeId.from("test#GetCallerIdentityRequest"))
                    .output(ShapeId.from("test#GetCallerIdentityResponse"))
                    .addError(ShapeId.from("test#ExpiredTokenException"))
                    .addTrait(DocumentationTrait("Returns details about the calling identity."))
                    .build()
            )
            // GetAccessKeyInfo operation (has input fields)
            .addShape(
                StructureShape.builder()
                    .id("test#GetAccessKeyInfoRequest")
                    .addMember("AccessKeyId", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#GetAccessKeyInfoResponse")
                    .addMember("Account", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#GetAccessKeyInfo")
                    .input(ShapeId.from("test#GetAccessKeyInfoRequest"))
                    .output(ShapeId.from("test#GetAccessKeyInfoResponse"))
                    .addError(ShapeId.from("test#ExpiredTokenException"))
                    .addError(ShapeId.from("test#InternalError"))
                    .build()
            )
            // Service
            .addShape(
                ServiceShape.builder()
                    .id("test#TestService")
                    .version("2011-06-15")
                    .addOperation(ShapeId.from("test#GetCallerIdentity"))
                    .addOperation(ShapeId.from("test#GetAccessKeyInfo"))
                    .build()
            )
            .assemble()
            .unwrap()
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

    private fun generateAndGetFiles(): Map<String, String> {
        val model = buildTestModel()
        val context = createContext(model)
        val service = model.expectShape(
            ShapeId.from("test#TestService"),
            ServiceShape::class.java,
        )

        ServiceGenerator(context, service, model, AwsQueryProtocol()).run()
        context.writerDelegator().flushWriters()

        val files = mutableMapOf<String, String>()
        for (file in context.fileManifest().files) {
            files[file.fileName.toString()] = file.toFile().readText()
        }
        return files
    }

    // ---- Error Generator Tests ----

    @Test
    fun errorsFileContainsServiceErrorUnion() {
        val files = generateAndGetFiles()
        val errors = files["errors.zig"]!!

        assertTrue(errors.contains("pub const ServiceError = struct"), "Missing ServiceError struct")
        assertTrue(errors.contains("arena: ?std.heap.ArenaAllocator = null"), "Missing arena field")
        assertTrue(errors.contains("kind: Kind"), "Missing kind field")
        assertTrue(errors.contains("pub const Kind = union(enum)"), "Missing Kind union")
        assertTrue(errors.contains("expired_token_exception: ExpiredTokenException"), "Missing ExpiredTokenException variant")
        assertTrue(errors.contains("internal_error: InternalError"), "Missing InternalError variant")
        assertTrue(errors.contains("unknown: UnknownServiceError"), "Missing unknown variant")
    }

    @Test
    fun errorsFileContainsCodeMethod() {
        val files = generateAndGetFiles()
        val errors = files["errors.zig"]!!

        assertTrue(errors.contains("pub fn code(self: ServiceError) []const u8"), "Missing code() method")
        assertTrue(errors.contains(".expired_token_exception => \"ExpiredTokenException\""), "Missing ExpiredTokenException code")
        assertTrue(errors.contains(".unknown => |e| e.code"), "Missing unknown code fallback")
    }

    @Test
    fun errorsFileContainsMessageMethod() {
        val files = generateAndGetFiles()
        val errors = files["errors.zig"]!!

        assertTrue(errors.contains("pub fn message(self: ServiceError) []const u8"), "Missing message() method")
        assertTrue(errors.contains(".expired_token_exception => |e| e.message"), "Missing message switch arm")
    }

    @Test
    fun errorsFileContainsHttpStatusMethod() {
        val files = generateAndGetFiles()
        val errors = files["errors.zig"]!!

        assertTrue(errors.contains("pub fn httpStatus(self: ServiceError) u16"), "Missing httpStatus() method")
        assertTrue(errors.contains(".expired_token_exception => 400"), "Client error should be 400")
        assertTrue(errors.contains(".internal_error => 500"), "Server error should be 500")
    }

    @Test
    fun errorsFileContainsErrorStructs() {
        val files = generateAndGetFiles()
        val errors = files["errors.zig"]!!

        assertTrue(errors.contains("pub const ExpiredTokenException = struct"), "Missing ExpiredTokenException struct")
        assertTrue(errors.contains("pub const InternalError = struct"), "Missing InternalError struct")
        assertTrue(errors.contains("pub const UnknownServiceError = struct"), "Missing UnknownServiceError struct")
        assertTrue(errors.contains("pub fn deinit(self: *ServiceError)"), "Missing deinit method")
    }

    // ---- Client Generator Tests ----

    @Test
    fun clientFileContainsClientStruct() {
        val files = generateAndGetFiles()
        val client = files["client.zig"]!!

        assertTrue(client.contains("pub const Client = struct"), "Missing Client struct")
        assertTrue(client.contains("allocator: std.mem.Allocator"), "Missing allocator field")
        assertTrue(client.contains("config: *aws.Config"), "Missing config field")
        assertTrue(client.contains("http_client: aws.http.HttpClient"), "Missing http_client field")
    }

    @Test
    fun clientFileContainsInitDeinit() {
        val files = generateAndGetFiles()
        val client = files["client.zig"]!!

        assertTrue(client.contains("pub fn init("), "Missing init function")
        assertTrue(client.contains("pub fn deinit("), "Missing deinit function")
        assertTrue(client.contains("self.http_client.deinit()"), "Missing http_client cleanup")
        assertTrue(client.contains("config.retry_mode"), "Missing retry_mode wiring")
    }

    @Test
    fun clientFileContainsOperationMethods() {
        val files = generateAndGetFiles()
        val client = files["client.zig"]!!

        assertTrue(client.contains("pub fn getCallerIdentity("), "Missing getCallerIdentity method")
        assertTrue(client.contains("pub fn getAccessKeyInfo("), "Missing getAccessKeyInfo method")
    }

    @Test
    fun clientFileImportsOperationModules() {
        val files = generateAndGetFiles()
        val client = files["client.zig"]!!

        assertTrue(
            client.contains("@import(\"get_caller_identity.zig\")"),
            "Missing get_caller_identity import",
        )
        assertTrue(
            client.contains("@import(\"get_access_key_info.zig\")"),
            "Missing get_access_key_info import",
        )
    }

    // ---- Operation Generator Tests ----

    @Test
    fun operationFileContainsInputOutput() {
        val files = generateAndGetFiles()
        val op = files["get_caller_identity.zig"]!!

        assertTrue(op.contains("pub const GetCallerIdentityInput = struct"), "Missing input struct")
        assertTrue(op.contains("pub const GetCallerIdentityOutput = struct"), "Missing output struct")
    }

    @Test
    fun operationOutputHasCorrectFields() {
        val files = generateAndGetFiles()
        val op = files["get_caller_identity.zig"]!!

        assertTrue(op.contains("account:"), "Missing account field")
        assertTrue(op.contains("arn:"), "Missing arn field")
        assertTrue(op.contains("user_id:"), "Missing user_id field")
    }

    @Test
    fun operationFileContainsExecuteFunction() {
        val files = generateAndGetFiles()
        val op = files["get_caller_identity.zig"]!!

        assertTrue(op.contains("pub fn execute("), "Missing execute function")
        assertTrue(op.contains("client: *Client"), "Missing client param")
        assertTrue(op.contains("allocator: std.mem.Allocator"), "Missing allocator param in execute")
        assertTrue(op.contains("ArenaAllocator"), "Missing arena allocator usage")
        assertTrue(op.contains("signRequest"), "Missing signing call")
    }

    @Test
    fun operationFileContainsSerializer() {
        val files = generateAndGetFiles()
        val op = files["get_caller_identity.zig"]!!

        assertTrue(op.contains("fn serializeRequest("), "Missing serializeRequest")
        assertTrue(op.contains("Action=GetCallerIdentity"), "Missing Action param")
        assertTrue(op.contains("Version=2011-06-15"), "Missing Version param")
    }

    @Test
    fun operationFileContainsDeserializer() {
        val files = generateAndGetFiles()
        val op = files["get_caller_identity.zig"]!!

        assertTrue(op.contains("fn deserializeResponse("), "Missing deserializeResponse")
        assertTrue(op.contains("findElement"), "Missing XML element finder")
    }

    @Test
    fun operationFileContainsErrorParser() {
        val files = generateAndGetFiles()
        val op = files["get_caller_identity.zig"]!!

        assertTrue(op.contains("fn parseErrorResponse("), "Missing parseErrorResponse")
        assertTrue(op.contains("\"ExpiredTokenException\""), "Missing error code matching")
    }

    @Test
    fun operationWithInputSerializesFields() {
        val files = generateAndGetFiles()
        val op = files["get_access_key_info.zig"]!!

        assertTrue(op.contains("pub const GetAccessKeyInfoInput = struct"), "Missing input struct")
        assertTrue(op.contains("access_key_id:"), "Missing access_key_id field")
        assertTrue(op.contains("AccessKeyId"), "Missing AccessKeyId in serializer")
    }

    @Test
    fun operationFileContainsOptionsStruct() {
        val files = generateAndGetFiles()
        val op = files["get_caller_identity.zig"]!!

        assertTrue(op.contains("pub const Options = struct"), "Missing Options struct")
        assertTrue(op.contains("diagnostic: ?*ServiceError"), "Missing diagnostic field")
    }

    // ---- Root Generator Tests ----

    @Test
    fun rootFileReexportsClient() {
        val files = generateAndGetFiles()
        val root = files["root.zig"]!!

        assertTrue(root.contains("pub const Client = @import(\"client.zig\").Client"), "Missing Client re-export")
        assertTrue(root.contains("pub const ServiceError = errors.ServiceError"), "Missing ServiceError re-export")
    }

    @Test
    fun rootFileReexportsOperations() {
        val files = generateAndGetFiles()
        val root = files["root.zig"]!!

        assertTrue(
            root.contains("pub const get_caller_identity = @import(\"get_caller_identity.zig\")"),
            "Missing get_caller_identity re-export",
        )
        assertTrue(
            root.contains("pub const get_access_key_info = @import(\"get_access_key_info.zig\")"),
            "Missing get_access_key_info re-export",
        )
    }

    // ---- Shared Type Import Tests ----

    @Test
    fun operationFileImportsSharedTypes() {
        val files = generateAndGetFiles()
        val op = files["get_caller_identity.zig"]!!

        assertTrue(
            op.contains("const Credentials = @import(\"credentials.zig\").Credentials;"),
            "Missing Credentials import in operation file",
        )
    }

    // ---- Service Name Parameterization Tests ----

    @Test
    fun operationUsesPackageNameForSigning() {
        val files = generateAndGetFiles()
        val op = files["get_caller_identity.zig"]!!

        assertTrue(
            op.contains("\"test_service\""),
            "Operation should use package name for signing/endpoint",
        )
    }

    // ---- File List Test ----

    @Test
    fun allExpectedFilesGenerated() {
        val files = generateAndGetFiles()
        val expectedFiles = listOf(
            "errors.zig",
            "client.zig",
            "root.zig",
            "get_caller_identity.zig",
            "get_access_key_info.zig",
        )
        for (expected in expectedFiles) {
            assertTrue(files.containsKey(expected), "Missing generated file: $expected")
        }
    }
}

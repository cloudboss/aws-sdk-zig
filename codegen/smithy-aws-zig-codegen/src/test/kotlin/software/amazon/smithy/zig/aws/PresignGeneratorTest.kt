package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertFalse
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
import software.amazon.smithy.model.traits.ErrorTrait
import software.amazon.smithy.model.traits.HttpTrait
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigSymbolVisitor
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.aws.protocols.AwsJsonProtocol
import software.amazon.smithy.zig.aws.protocols.RestJsonProtocol
import software.amazon.smithy.zig.generators.OperationGenerator
import software.amazon.smithy.zig.generators.ServiceGenerator
import java.nio.file.Path

class PresignGeneratorTest {

    @TempDir
    lateinit var tempDir: Path

    /**
     * Build a model with a presignable operation (com.amazonaws.s3#GetObject)
     * and a non-presignable operation using restJson protocol.
     */
    private fun buildRestJsonPresignModel(): Model {
        return Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("com.amazonaws.s3#NoSuchKey")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("com.amazonaws.s3#GetObjectInput")
                    .addMember("Bucket", ShapeId.from("smithy.api#String"))
                    .addMember("Key", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("com.amazonaws.s3#GetObjectOutput")
                    .addMember("Body", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("com.amazonaws.s3#GetObject")
                    .input(ShapeId.from("com.amazonaws.s3#GetObjectInput"))
                    .output(ShapeId.from("com.amazonaws.s3#GetObjectOutput"))
                    .addError(ShapeId.from("com.amazonaws.s3#NoSuchKey"))
                    .addTrait(
                        HttpTrait.builder()
                            .method("GET")
                            .uri(software.amazon.smithy.model.pattern.UriPattern.parse("/{Bucket}/{Key+}"))
                            .code(200)
                            .build()
                    )
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("com.amazonaws.s3#ListBucketsInput")
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("com.amazonaws.s3#ListBucketsOutput")
                    .addMember("Buckets", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("com.amazonaws.s3#ListBuckets")
                    .input(ShapeId.from("com.amazonaws.s3#ListBucketsInput"))
                    .output(ShapeId.from("com.amazonaws.s3#ListBucketsOutput"))
                    .addTrait(
                        HttpTrait.builder()
                            .method("GET")
                            .uri(software.amazon.smithy.model.pattern.UriPattern.parse("/"))
                            .code(200)
                            .build()
                    )
                    .build()
            )
            .addShape(
                ServiceShape.builder()
                    .id("com.amazonaws.s3#AmazonS3")
                    .version("2006-03-01")
                    .addOperation(ShapeId.from("com.amazonaws.s3#GetObject"))
                    .addOperation(ShapeId.from("com.amazonaws.s3#ListBuckets"))
                    .build()
            )
            .assemble()
            .result
            .get()
    }

    /** Build an awsJson model -- no operations should get presign. */
    private fun buildAwsJsonModel(): Model {
        return Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#InternalError")
                    .addTrait(ErrorTrait("server"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
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
                    .addMember("TableNames", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#ListTables")
                    .input(ShapeId.from("test#ListTablesInput"))
                    .output(ShapeId.from("test#ListTablesOutput"))
                    .addError(ShapeId.from("test#InternalError"))
                    .build()
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#TestService")
                    .version("2012-08-10")
                    .addOperation(ShapeId.from("test#ListTables"))
                    .build()
            )
            .assemble()
            .unwrap()
    }

    private fun generateFiles(model: Model, serviceId: String, packageName: String, protocol: software.amazon.smithy.zig.protocols.ProtocolGenerator): Map<String, String> {
        val settings = ZigSettings(
            ShapeId.from(serviceId),
            packageName,
            ".",
        )
        val symbolProvider = ZigSymbolVisitor(model, settings.packageName)
        val fileManifest = FileManifest.create(tempDir)
        val delegator = WriterDelegator(fileManifest, symbolProvider, ZigWriter.factory())
        val service = model.expectShape(settings.service, ServiceShape::class.java)
        val context = ZigContext(
            model = model,
            settings = settings,
            symbolProvider = symbolProvider,
            fileManifest = fileManifest,
            writerDelegator = delegator,
            integrations = listOf(),
            service = service,
        )

        ServiceGenerator(context, service, model, protocol).run()
        context.writerDelegator().flushWriters()

        val files = mutableMapOf<String, String>()
        for (file in context.fileManifest().files) {
            files[file.fileName.toString()] = file.toFile().readText()
        }
        return files
    }

    // ---- RestJson presign tests ----

    @Test
    fun presignFunctionGenerated() {
        val files = generateFiles(buildRestJsonPresignModel(), "com.amazonaws.s3#AmazonS3", "s3", RestJsonProtocol())
        val op = files["get_object.zig"]!!
        assertTrue(op.contains("pub fn presign("), "Missing presign function")
    }

    @Test
    fun presignOptionsGenerated() {
        val files = generateFiles(buildRestJsonPresignModel(), "com.amazonaws.s3#AmazonS3", "s3", RestJsonProtocol())
        val op = files["get_object.zig"]!!
        assertTrue(op.contains("pub const PresignOptions = struct"), "Missing PresignOptions struct")
        assertTrue(op.contains("expires_seconds: u64 = 3600"), "Missing expires_seconds field")
    }

    @Test
    fun presignCallsPresignRequest() {
        val files = generateFiles(buildRestJsonPresignModel(), "com.amazonaws.s3#AmazonS3", "s3", RestJsonProtocol())
        val op = files["get_object.zig"]!!
        assertTrue(op.contains("aws.signing.presignRequest"), "Should call presignRequest")
    }

    @Test
    fun presignUsesCorrectServiceName() {
        val files = generateFiles(buildRestJsonPresignModel(), "com.amazonaws.s3#AmazonS3", "s3", RestJsonProtocol())
        val op = files["get_object.zig"]!!
        assertTrue(op.contains("\"s3\""), "Should use 's3' as service name")
    }

    @Test
    fun clientHasPresignMethod() {
        val files = generateFiles(buildRestJsonPresignModel(), "com.amazonaws.s3#AmazonS3", "s3", RestJsonProtocol())
        val client = files["client.zig"]!!
        assertTrue(client.contains("pub fn presignGetObject("), "Missing presignGetObject method")
    }

    @Test
    fun nonPresignableOperationHasNoPresign() {
        val files = generateFiles(buildRestJsonPresignModel(), "com.amazonaws.s3#AmazonS3", "s3", RestJsonProtocol())
        val op = files["list_buckets.zig"]!!
        assertFalse(op.contains("presign"), "ListBuckets should NOT have presign")
    }

    @Test
    fun clientHasNoPresignForNonPresignable() {
        val files = generateFiles(buildRestJsonPresignModel(), "com.amazonaws.s3#AmazonS3", "s3", RestJsonProtocol())
        val client = files["client.zig"]!!
        assertFalse(client.contains("presignListBuckets"), "ListBuckets should NOT have presign method")
    }

    // ---- AwsJson tests (no presign) ----

    @Test
    fun awsJsonNoPresign() {
        val files = generateFiles(buildAwsJsonModel(), "test#TestService", "test_service", AwsJsonProtocol("1.0"))
        val op = files["list_tables.zig"]!!
        assertFalse(op.contains("presign"), "awsJson operations should not have presign")
    }

    // ---- Presignable allowlist tests ----

    @Test
    fun presignableOperationsConstant() {
        assertTrue(
            OperationGenerator.PRESIGNABLE_OPERATIONS.contains("com.amazonaws.s3#GetObject"),
            "GetObject should be presignable",
        )
        assertTrue(
            OperationGenerator.PRESIGNABLE_OPERATIONS.contains("com.amazonaws.sts#GetCallerIdentity"),
            "GetCallerIdentity should be presignable",
        )
        assertFalse(
            OperationGenerator.PRESIGNABLE_OPERATIONS.contains("com.amazonaws.s3#ListBuckets"),
            "ListBuckets should NOT be presignable",
        )
    }
}

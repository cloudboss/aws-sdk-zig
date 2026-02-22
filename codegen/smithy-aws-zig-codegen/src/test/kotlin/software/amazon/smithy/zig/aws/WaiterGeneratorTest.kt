package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.node.Node
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
import software.amazon.smithy.zig.aws.protocols.RestJsonProtocol
import software.amazon.smithy.zig.generators.ServiceGenerator
import software.amazon.smithy.zig.generators.WaiterGenerator
import software.amazon.smithy.waiters.WaitableTrait
import java.nio.file.Path

class WaiterGeneratorTest {

    @TempDir
    lateinit var tempDir: Path

    /** Build a WaitableTrait from JSON node representation. */
    private fun buildWaitableTrait(json: String): WaitableTrait {
        val node = Node.parse(json)
        return WaitableTrait.Provider().createTrait(
            ShapeId.from("smithy.waiters#waitable"),
            node,
        ) as WaitableTrait
    }

    /**
     * Build a model with a waitable operation (success acceptor: HeadBucket style)
     * and a non-waitable operation.
     */
    private fun buildSuccessWaiterModel(): Model {
        val waitable = buildWaitableTrait(
            """
            {
                "BucketExists": {
                    "acceptors": [
                        {
                            "state": "success",
                            "matcher": { "success": true }
                        },
                        {
                            "state": "retry",
                            "matcher": { "errorType": "NotFound" }
                        }
                    ],
                    "minDelay": 5
                }
            }
            """,
        )

        return Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#NotFound")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build(),
            )
            .addShape(
                StructureShape.builder()
                    .id("test#HeadBucketInput")
                    .addMember("Bucket", ShapeId.from("smithy.api#String"))
                    .build(),
            )
            .addShape(
                StructureShape.builder()
                    .id("test#HeadBucketOutput")
                    .build(),
            )
            .addShape(
                OperationShape.builder()
                    .id("test#HeadBucket")
                    .input(ShapeId.from("test#HeadBucketInput"))
                    .output(ShapeId.from("test#HeadBucketOutput"))
                    .addError(ShapeId.from("test#NotFound"))
                    .addTrait(waitable)
                    .addTrait(
                        HttpTrait.builder()
                            .method("HEAD")
                            .uri(software.amazon.smithy.model.pattern.UriPattern.parse("/{Bucket}"))
                            .code(200)
                            .build(),
                    )
                    .build(),
            )
            .addShape(
                StructureShape.builder()
                    .id("test#ListBucketsInput")
                    .build(),
            )
            .addShape(
                StructureShape.builder()
                    .id("test#ListBucketsOutput")
                    .build(),
            )
            .addShape(
                OperationShape.builder()
                    .id("test#ListBuckets")
                    .input(ShapeId.from("test#ListBucketsInput"))
                    .output(ShapeId.from("test#ListBucketsOutput"))
                    .addTrait(
                        HttpTrait.builder()
                            .method("GET")
                            .uri(software.amazon.smithy.model.pattern.UriPattern.parse("/"))
                            .code(200)
                            .build(),
                    )
                    .build(),
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#TestService")
                    .version("2006-03-01")
                    .addOperation(ShapeId.from("test#HeadBucket"))
                    .addOperation(ShapeId.from("test#ListBuckets"))
                    .build(),
            )
            .assemble()
            .result
            .get()
    }

    /**
     * Build a model with an output path matcher waiter (DynamoDB TableExists style).
     */
    private fun buildOutputPathWaiterModel(): Model {
        val waitable = buildWaitableTrait(
            """
            {
                "TableExists": {
                    "acceptors": [
                        {
                            "state": "success",
                            "matcher": {
                                "output": {
                                    "path": "Table.TableStatus",
                                    "expected": "ACTIVE",
                                    "comparator": "stringEquals"
                                }
                            }
                        },
                        {
                            "state": "retry",
                            "matcher": { "errorType": "ResourceNotFoundException" }
                        }
                    ],
                    "minDelay": 20
                }
            }
            """,
        )

        return Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#ResourceNotFoundException")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build(),
            )
            .addShape(
                StructureShape.builder()
                    .id("test#DescribeTableInput")
                    .addMember("TableName", ShapeId.from("smithy.api#String"))
                    .build(),
            )
            .addShape(
                StructureShape.builder()
                    .id("test#TableDescription")
                    .addMember("TableStatus", ShapeId.from("smithy.api#String"))
                    .build(),
            )
            .addShape(
                StructureShape.builder()
                    .id("test#DescribeTableOutput")
                    .addMember("Table", ShapeId.from("test#TableDescription"))
                    .build(),
            )
            .addShape(
                OperationShape.builder()
                    .id("test#DescribeTable")
                    .input(ShapeId.from("test#DescribeTableInput"))
                    .output(ShapeId.from("test#DescribeTableOutput"))
                    .addError(ShapeId.from("test#ResourceNotFoundException"))
                    .addTrait(waitable)
                    .addTrait(
                        HttpTrait.builder()
                            .method("POST")
                            .uri(software.amazon.smithy.model.pattern.UriPattern.parse("/"))
                            .code(200)
                            .build(),
                    )
                    .build(),
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#TestService")
                    .version("2012-08-10")
                    .addOperation(ShapeId.from("test#DescribeTable"))
                    .build(),
            )
            .assemble()
            .result
            .get()
    }

    private fun generateFiles(model: Model, serviceId: String, packageName: String): Map<String, String> {
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

        ServiceGenerator(context, service, model, RestJsonProtocol()).run()
        context.writerDelegator().flushWriters()

        val files = mutableMapOf<String, String>()
        for (file in context.fileManifest().files) {
            files[file.fileName.toString()] = file.toFile().readText()
        }
        return files
    }

    // ---- Success acceptor tests ----

    @Test
    fun waiterStructGenerated() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(waitersFile.contains("pub const BucketExistsWaiter = struct"), "Missing waiter struct")
    }

    @Test
    fun waiterHasWaitMethod() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(waitersFile.contains("pub fn wait(self: *Self) aws.waiter.WaiterError!void"), "Missing wait method")
    }

    @Test
    fun waiterHasPollMethod() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(waitersFile.contains("fn poll(self: *Self) aws.waiter.AcceptorState"), "Missing poll method")
    }

    @Test
    fun waiterHasMinDelay() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(waitersFile.contains(".min_delay_s = 5"), "Missing min_delay_s config")
    }

    @Test
    fun waiterSuccessAcceptorGeneratesReturn() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(waitersFile.contains("return .success;"), "Missing success return in poll")
    }

    @Test
    fun waiterErrorTypeAcceptorGeneratesCodeCheck() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(
            waitersFile.contains("diagnostic.code()") && waitersFile.contains("\"NotFound\"") && waitersFile.contains("diagnostic.deinit()"),
            "Missing errorType check for NotFound or diagnostic.deinit()",
        )
    }

    @Test
    fun waiterImportsOperationModule() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(waitersFile.contains("@import(\"head_bucket.zig\")"), "Missing operation module import")
    }

    @Test
    fun waiterClientMethodGenerated() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val client = files["client.zig"]!!
        assertTrue(
            client.contains("pub fn waitUntilBucketExists("),
            "Missing waitUntilBucketExists client method",
        )
    }

    @Test
    fun waiterClientImportsWaiters() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val client = files["client.zig"]!!
        assertTrue(
            client.contains("@import(\"waiters.zig\")"),
            "Missing waiters import in client",
        )
    }

    @Test
    fun nonWaitableOperationHasNoWaiter() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertFalse(waitersFile.contains("ListBuckets"), "ListBuckets should not appear in waiters")
    }

    @Test
    fun rootExportsWaiters() {
        val files = generateFiles(buildSuccessWaiterModel(), "test#TestService", "test_service")
        val root = files["root.zig"]!!
        assertTrue(root.contains("@import(\"waiters.zig\")"), "Missing waiters re-export in root")
    }

    // ---- Output path matcher tests ----

    @Test
    fun outputPathWaiterGenerated() {
        val files = generateFiles(buildOutputPathWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(
            waitersFile.contains("pub const TableExistsWaiter = struct"),
            "Missing TableExistsWaiter struct",
        )
    }

    @Test
    fun outputPathMinDelay() {
        val files = generateFiles(buildOutputPathWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(waitersFile.contains(".min_delay_s = 20"), "Missing min_delay_s = 20")
    }

    @Test
    fun outputPathChecksFieldChain() {
        val files = generateFiles(buildOutputPathWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(
            waitersFile.contains("output.table") || waitersFile.contains("output.Table"),
            "Missing output.table field access",
        )
        assertTrue(
            waitersFile.contains("\"ACTIVE\""),
            "Missing ACTIVE comparison value",
        )
    }

    @Test
    fun outputPathErrorTypeRetry() {
        val files = generateFiles(buildOutputPathWaiterModel(), "test#TestService", "test_service")
        val waitersFile = files["waiters.zig"]!!
        assertTrue(
            waitersFile.contains("\"ResourceNotFoundException\""),
            "Missing ResourceNotFoundException error check",
        )
    }

    @Test
    fun outputPathClientWaitMethod() {
        val files = generateFiles(buildOutputPathWaiterModel(), "test#TestService", "test_service")
        val client = files["client.zig"]!!
        assertTrue(
            client.contains("pub fn waitUntilTableExists("),
            "Missing waitUntilTableExists client method",
        )
    }

    // ---- Waiter collectWaiters tests ----

    @Test
    fun collectWaitersReturnsCorrectInfo() {
        val model = buildSuccessWaiterModel()
        val service = model.expectShape(ShapeId.from("test#TestService"), ServiceShape::class.java)
        val settings = ZigSettings(ShapeId.from("test#TestService"), "test_service", ".")
        val symbolProvider = ZigSymbolVisitor(model, settings.packageName)
        val fileManifest = FileManifest.create(tempDir)
        val delegator = WriterDelegator(fileManifest, symbolProvider, ZigWriter.factory())
        val context = ZigContext(
            model = model,
            settings = settings,
            symbolProvider = symbolProvider,
            fileManifest = fileManifest,
            writerDelegator = delegator,
            integrations = listOf(),
            service = service,
        )
        val gen = WaiterGenerator(context, service, model)
        val waiters = gen.collectWaiters()

        assertTrue(waiters.size == 1, "Expected 1 waiter, got ${waiters.size}")
        assertTrue(waiters[0].waiterName == "BucketExists", "Expected BucketExists waiter")
        assertTrue(waiters[0].operationName == "HeadBucket", "Expected HeadBucket operation")
        assertTrue(waiters[0].minDelay == 5, "Expected minDelay 5")
        assertTrue(waiters[0].acceptors.size == 2, "Expected 2 acceptors")
    }
}

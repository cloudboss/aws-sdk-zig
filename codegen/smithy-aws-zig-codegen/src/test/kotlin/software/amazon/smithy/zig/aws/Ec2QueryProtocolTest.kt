package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.ErrorTrait
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigSymbolVisitor
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.aws.protocols.AwsQueryProtocol
import software.amazon.smithy.zig.aws.protocols.Ec2QueryProtocol
import software.amazon.smithy.zig.generators.ServiceGenerator
import java.nio.file.Path

class Ec2QueryProtocolTest {

    @TempDir
    lateinit var tempDir: Path

    private fun buildTestModel(): Model {
        return Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#InvalidParameterException")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#DescribeInstancesRequest")
                    .addMember("InstanceId", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#DescribeInstancesResponse")
                    .addMember("ReservationId", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#DescribeInstances")
                    .input(ShapeId.from("test#DescribeInstancesRequest"))
                    .output(ShapeId.from("test#DescribeInstancesResponse"))
                    .addError(ShapeId.from("test#InvalidParameterException"))
                    .build()
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#Ec2Service")
                    .version("2016-11-15")
                    .addOperation(ShapeId.from("test#DescribeInstances"))
                    .build()
            )
            .assemble()
            .unwrap()
    }

    private fun createContext(model: Model): ZigContext {
        val settings = ZigSettings(
            ShapeId.from("test#Ec2Service"),
            "ec2",
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

    private fun generateFiles(protocol: software.amazon.smithy.zig.protocols.ProtocolGenerator): Map<String, String> {
        return generateFilesFromModel(buildTestModel(), protocol)
    }

    private fun generateFilesFromModel(
        model: Model,
        protocol: software.amazon.smithy.zig.protocols.ProtocolGenerator,
    ): Map<String, String> {
        val context = createContext(model)
        val service = model.expectShape(
            ShapeId.from("test#Ec2Service"),
            ServiceShape::class.java,
        )

        ServiceGenerator(context, service, model, protocol).run()
        context.writerDelegator().flushWriters()

        val files = mutableMapOf<String, String>()
        for (file in context.fileManifest().files) {
            files[file.fileName.toString()] = file.toFile().readText()
        }
        return files
    }

    // ---- EC2 Query uses RequestID (capital D) ----

    @Test
    fun errorParserUsesRequestIDWithCapitalD() {
        val files = generateFiles(Ec2QueryProtocol())
        val op = files["describe_instances.zig"]!!

        assertTrue(
            op.contains("\"RequestID\""),
            "EC2 Query should use RequestID (capital D)",
        )
        assertFalse(
            op.contains("\"RequestId\""),
            "EC2 Query should NOT use RequestId (lowercase d)",
        )
    }

    // ---- Verify AwsQuery uses RequestId (lowercase d) for contrast ----

    @Test
    fun awsQueryUsesRequestIdWithLowercaseD() {
        val files = generateFiles(AwsQueryProtocol())
        val op = files["describe_instances.zig"]!!

        assertTrue(
            op.contains("\"RequestId\""),
            "AWS Query should use RequestId (lowercase d)",
        )
        assertFalse(
            op.contains("\"RequestID\""),
            "AWS Query should NOT use RequestID (capital D)",
        )
    }

    // ---- Serialization is inherited (same as AWS Query) ----

    @Test
    fun serializerUsesActionAndVersion() {
        val files = generateFiles(Ec2QueryProtocol())
        val op = files["describe_instances.zig"]!!

        assertTrue(op.contains("Action=DescribeInstances"), "Missing Action param")
        assertTrue(op.contains("Version=2016-11-15"), "Missing Version param")
    }

    @Test
    fun serializerEncodesInputFields() {
        val files = generateFiles(Ec2QueryProtocol())
        val op = files["describe_instances.zig"]!!

        assertTrue(op.contains("InstanceId"), "Missing InstanceId in serializer")
        assertTrue(op.contains("appendUrlEncoded"), "Missing URL encoding call")
    }

    @Test
    fun contentTypeIsFormUrlEncoded() {
        val protocol = Ec2QueryProtocol()
        assertTrue(
            protocol.contentType() == "application/x-www-form-urlencoded",
            "EC2 Query should use form-urlencoded content type",
        )
    }

    // ---- Deserialization is inherited ----

    @Test
    fun deserializerUsesFindElement() {
        val files = generateFiles(Ec2QueryProtocol())
        val op = files["describe_instances.zig"]!!

        assertTrue(op.contains("fn deserializeResponse("), "Missing deserializeResponse")
        assertTrue(op.contains("findElement"), "Missing findElement usage")
    }

    // ---- Error code matching works ----

    @Test
    fun errorParserMatchesErrorCodes() {
        val files = generateFiles(Ec2QueryProtocol())
        val op = files["describe_instances.zig"]!!

        assertTrue(op.contains("fn parseErrorResponse("), "Missing parseErrorResponse")
        assertTrue(
            op.contains("\"InvalidParameterException\""),
            "Missing error code matching for InvalidParameterException",
        )
    }

    // ---- Helper functions are present ----

    @Test
    fun helperFunctionsPresent() {
        val files = generateFiles(Ec2QueryProtocol())
        val op = files["describe_instances.zig"]!!

        assertTrue(op.contains("fn findElement("), "Missing findElement helper")
        assertTrue(op.contains("fn appendUrlEncoded("), "Missing appendUrlEncoded helper")
        assertTrue(op.contains("fn parseHost("), "Missing parseHost helper")
        assertTrue(op.contains("fn parsePort("), "Missing parsePort helper")
    }

    // ---- Nested struct/list serialization tests ----

    private fun buildNestedTestModel(): Model {
        return Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#InvalidParameterException")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#Address")
                    .addMember("Street", ShapeId.from("smithy.api#String"))
                    .addMember("City", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#Instance")
                    .addMember("Name", ShapeId.from("smithy.api#String"))
                    .addMember("Address", ShapeId.from("test#Address"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#Tag")
                    .addMember("Key", ShapeId.from("smithy.api#String"))
                    .addMember("Value", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                ListShape.builder()
                    .id("test#TagList")
                    .member(ShapeId.from("test#Tag"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#Wrapper")
                    .addMember("Inner", ShapeId.from("test#Address"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#CreateInstanceRequest")
                    .addMember("Instance", ShapeId.from("test#Instance"))
                    .addMember("Tags", ShapeId.from("test#TagList"))
                    .addMember("Wrapper", ShapeId.from("test#Wrapper"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#CreateInstanceResponse")
                    .addMember("InstanceId", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#CreateInstance")
                    .input(ShapeId.from("test#CreateInstanceRequest"))
                    .output(ShapeId.from("test#CreateInstanceResponse"))
                    .addError(ShapeId.from("test#InvalidParameterException"))
                    .build()
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#Ec2Service")
                    .version("2016-11-15")
                    .addOperation(ShapeId.from("test#CreateInstance"))
                    .build()
            )
            .assemble()
            .unwrap()
    }

    @Test
    fun nestedStructFieldsSerialized() {
        val files = generateFilesFromModel(buildNestedTestModel(), Ec2QueryProtocol())
        val op = files["create_instance.zig"]!!

        assertTrue(op.contains("Instance.Name"), "Missing Instance.Name in serializer")
        assertTrue(op.contains("Instance.Address.Street"), "Missing nested Instance.Address.Street")
        assertTrue(op.contains("Instance.Address.City"), "Missing nested Instance.Address.City")
    }

    @Test
    fun listOfStructsSerialized() {
        val files = generateFilesFromModel(buildNestedTestModel(), Ec2QueryProtocol())
        val op = files["create_instance.zig"]!!

        assertTrue(op.contains("Tags.member.{d}.Key"), "Missing Tags.member.{d}.Key")
        assertTrue(op.contains("Tags.member.{d}.Value"), "Missing Tags.member.{d}.Value")
    }

    @Test
    fun nestedStructInListSerialized() {
        val files = generateFilesFromModel(buildNestedTestModel(), Ec2QueryProtocol())
        val op = files["create_instance.zig"]!!

        // Instance.Address nested struct fields should not be skipped
        assertTrue(op.contains("Instance.Address.Street"), "Nested struct within struct was skipped")
        assertTrue(op.contains("Instance.Address.City"), "Nested struct within struct was skipped")
    }

    @Test
    fun hasSerializableFieldsRecursive() {
        val files = generateFilesFromModel(buildNestedTestModel(), Ec2QueryProtocol())
        val op = files["create_instance.zig"]!!

        // Wrapper has no scalar fields of its own, only a nested struct Inner (Address)
        // hasSerializableFields should still return true and serialize the nested fields
        assertTrue(op.contains("Wrapper.Inner.Street"), "Struct with only nested struct members was skipped")
        assertTrue(op.contains("Wrapper.Inner.City"), "Struct with only nested struct members was skipped")
    }
}

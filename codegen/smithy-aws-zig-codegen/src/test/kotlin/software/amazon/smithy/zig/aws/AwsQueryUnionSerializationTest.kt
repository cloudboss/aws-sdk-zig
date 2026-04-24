package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.traits.ErrorTrait
import software.amazon.smithy.model.traits.XmlNameTrait
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigSymbolVisitor
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.aws.protocols.AwsQueryProtocol
import software.amazon.smithy.zig.aws.protocols.Ec2QueryProtocol
import software.amazon.smithy.zig.generators.ServiceGenerator
import software.amazon.smithy.zig.protocols.ProtocolGenerator
import java.nio.file.Path

class AwsQueryUnionSerializationTest {

    @TempDir
    lateinit var tempDir: Path

    private fun buildUnionModel(): Model {
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
                    .id("test#PromQLCriteria")
                    .addMember("Query", ShapeId.from("smithy.api#String"))
                    .addMember("PendingPeriod", ShapeId.from("smithy.api#Integer"))
                    .build()
            )
            .addShape(
                UnionShape.builder()
                    .id("test#Criteria")
                    .addMember("PromQL", ShapeId.from("test#PromQLCriteria"))
                    .addMember("Literal", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#Item")
                    .addMember("Name", ShapeId.from("smithy.api#String"))
                    .addMember("Criteria", ShapeId.from("test#Criteria"))
                    .build()
            )
            .addShape(
                ListShape.builder()
                    .id("test#ItemList")
                    .member(ShapeId.from("test#Item"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#PutThingRequest")
                    .addMember("Criteria", ShapeId.from("test#Criteria"))
                    .addMember("Items", ShapeId.from("test#ItemList"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#PutThingResponse")
                    .addMember("Id", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#PutThing")
                    .input(ShapeId.from("test#PutThingRequest"))
                    .output(ShapeId.from("test#PutThingResponse"))
                    .addError(ShapeId.from("test#InvalidParameterException"))
                    .build()
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#TestService")
                    .version("2024-01-01")
                    .addOperation(ShapeId.from("test#PutThing"))
                    .build()
            )
            .assemble()
            .unwrap()
    }

    private fun createContext(model: Model): ZigContext {
        val settings = ZigSettings(
            ShapeId.from("test#TestService"),
            "testservice",
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

    private fun generate(
        protocol: ProtocolGenerator,
        model: Model = buildUnionModel(),
    ): Map<String, String> {
        val context = createContext(model)
        val service = model.expectShape(
            ShapeId.from("test#TestService"),
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

    // Regression: the cloudwatch put_metric_alarm line-609 bug. A union-typed
    // member must not be funneled through the scalar serializer.
    @Test
    fun topLevelUnionIsNotPassedAsScalarToAppendUrlEncoded() {
        val op = generate(AwsQueryProtocol())["put_thing.zig"]!!
        val badPattern = Regex(
            """if \(input\.criteria\) \|v\| \{[^}]*appendUrlEncoded\(allocator, &body_buf, v\);""",
        )
        assertFalse(
            badPattern.containsMatchIn(op),
            "Top-level union must not fall through to scalar appendUrlEncoded",
        )
    }

    @Test
    fun topLevelUnionEmitsSwitch() {
        val op = generate(AwsQueryProtocol())["put_thing.zig"]!!
        assertTrue(op.contains("switch ("), "Union serializer should emit a switch expression")
        assertTrue(op.contains(".prom_ql =>"), "Missing .prom_ql arm in union switch")
        assertTrue(op.contains(".literal =>"), "Missing .literal arm in union switch")
    }

    @Test
    fun unionStructVariantEmbedsVariantNameInWireKey() {
        val op = generate(AwsQueryProtocol())["put_thing.zig"]!!
        assertTrue(
            op.contains("&Criteria.PromQL.Query="),
            "Struct variant fields should be prefixed with <parent>.<VariantName>",
        )
        assertTrue(
            op.contains("&Criteria.PromQL.PendingPeriod="),
            "All struct variant fields should appear under the variant prefix",
        )
    }

    @Test
    fun unionScalarVariantUsesVariantNameAsKey() {
        val op = generate(AwsQueryProtocol())["put_thing.zig"]!!
        assertTrue(
            op.contains("&Criteria.Literal="),
            "Scalar variant should serialize as <parent>.<VariantName>=value",
        )
    }

    @Test
    fun unionInsideListOfStructsSerialized() {
        val op = generate(AwsQueryProtocol())["put_thing.zig"]!!
        assertTrue(
            op.contains("Items.member.{d}.Criteria.PromQL.Query="),
            "Union inside a list of structs should thread list index + variant into the key",
        )
    }

    @Test
    fun ec2QueryInheritsUnionBehavior() {
        val op = generate(Ec2QueryProtocol())["put_thing.zig"]!!
        assertTrue(op.contains("switch ("), "Ec2Query should also emit a union switch")
        assertTrue(
            op.contains("&Criteria.PromQL.Query="),
            "Ec2Query union struct-variant wire key mismatch",
        )
        assertTrue(
            op.contains("Items.{d}.Criteria.PromQL.Query="),
            "Ec2Query union inside list should omit 'member' from the list prefix",
        )
    }

    @Test
    fun unionVariantXmlNameIsHonored() {
        val model = Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#InvalidParameterException")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                UnionShape.builder()
                    .id("test#Thing")
                    .addMember(
                        MemberShape.builder()
                            .id("test#Thing\$RawName")
                            .target(ShapeId.from("smithy.api#String"))
                            .addTrait(XmlNameTrait("CustomName"))
                            .build()
                    )
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#PutThingRequest")
                    .addMember("Thing", ShapeId.from("test#Thing"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#PutThingResponse")
                    .addMember("Id", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#PutThing")
                    .input(ShapeId.from("test#PutThingRequest"))
                    .output(ShapeId.from("test#PutThingResponse"))
                    .addError(ShapeId.from("test#InvalidParameterException"))
                    .build()
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#TestService")
                    .version("2024-01-01")
                    .addOperation(ShapeId.from("test#PutThing"))
                    .build()
            )
            .assemble()
            .unwrap()

        val op = generate(AwsQueryProtocol(), model)["put_thing.zig"]!!
        assertTrue(
            op.contains("&Thing.CustomName="),
            "Union variant with xmlName should use the overridden name on the wire",
        )
        assertFalse(
            op.contains("&Thing.RawName="),
            "Union variant xmlName should replace the raw member name",
        )
    }
}

package software.amazon.smithy.zig

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertNull
import org.junit.jupiter.api.Test
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.node.Node
import software.amazon.smithy.model.shapes.BooleanShape
import software.amazon.smithy.model.shapes.IntegerShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.traits.DefaultTrait

class DefaultValueUtilTest {
    private fun buildMemberShape(
        model: Model,
        memberId: String,
        targetId: String,
        defaultNode: Node? = null,
    ): MemberShape {
        val builder = MemberShape.builder()
            .id(memberId)
            .target(targetId)
        if (defaultNode != null) {
            builder.addTrait(DefaultTrait(defaultNode))
        }
        return builder.build()
    }

    private fun buildModel(vararg shapes: software.amazon.smithy.model.shapes.Shape): Model {
        val assembler = Model.assembler()
        for (shape in shapes) {
            assembler.addShape(shape)
        }
        return assembler.assemble().unwrap()
    }

    @Test
    fun resolvesBooleanDefault() {
        val model = buildModel(BooleanShape.builder().id("test#BoolTarget").build())
        val member = buildMemberShape(model, "test#Struct\$flag", "test#BoolTarget", Node.from(true))
        val symbolProvider = ZigSymbolVisitor(model, "test")

        val result = DefaultValueUtil.resolveDefaultValue(member, model, symbolProvider)
        assertEquals("bool", result?.typeName)
        assertEquals("true", result?.literal)
    }

    @Test
    fun resolvesNumberDefault() {
        val model = buildModel(IntegerShape.builder().id("test#IntTarget").build())
        val member = buildMemberShape(model, "test#Struct\$count", "test#IntTarget", Node.from(0))
        val symbolProvider = ZigSymbolVisitor(model, "test")

        val result = DefaultValueUtil.resolveDefaultValue(member, model, symbolProvider)
        assertEquals("i32", result?.typeName)
        assertEquals("0", result?.literal)
    }

    @Test
    fun resolvesEmptyStringDefault() {
        val model = buildModel(StringShape.builder().id("test#StringTarget").build())
        val member = buildMemberShape(model, "test#Struct\$name", "test#StringTarget", Node.from(""))
        val symbolProvider = ZigSymbolVisitor(model, "test")

        val result = DefaultValueUtil.resolveDefaultValue(member, model, symbolProvider)
        assertEquals("[]const u8", result?.typeName)
        assertEquals("\"\"", result?.literal)
    }

    @Test
    fun resolvesEmptyArrayDefault() {
        val listShape = ListShape.builder()
            .id("test#ListTarget")
            .member(
                MemberShape.builder()
                    .id("test#ListTarget\$member")
                    .target("smithy.api#String")
                    .build()
            )
            .build()
        val model = buildModel(listShape)
        val member = buildMemberShape(
            model,
            "test#Struct\$values",
            "test#ListTarget",
            Node.arrayNode(),
        )
        val symbolProvider = ZigSymbolVisitor(model, "test")

        val result = DefaultValueUtil.resolveDefaultValue(member, model, symbolProvider)
        assertEquals("[]const []const u8", result?.typeName)
        assertEquals("&.{}", result?.literal)
    }

    @Test
    fun nullDefaultFallsBackToOptional() {
        val model = buildModel(StringShape.builder().id("test#StringTarget").build())
        val member = buildMemberShape(model, "test#Struct\$name", "test#StringTarget", Node.nullNode())
        val symbolProvider = ZigSymbolVisitor(model, "test")

        val result = DefaultValueUtil.resolveDefaultValue(member, model, symbolProvider)
        assertNull(result)
    }

    @Test
    fun noTraitReturnsNull() {
        val model = buildModel(StringShape.builder().id("test#StringTarget").build())
        val member = buildMemberShape(model, "test#Struct\$name", "test#StringTarget")
        val symbolProvider = ZigSymbolVisitor(model, "test")

        val result = DefaultValueUtil.resolveDefaultValue(member, model, symbolProvider)
        assertNull(result)
    }
}

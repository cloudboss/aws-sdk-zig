package software.amazon.smithy.zig.generators

import software.amazon.smithy.codegen.core.directed.GenerateEnumDirective
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings

class EnumGenerator(
    private val directive: GenerateEnumDirective<ZigContext, ZigSettings>,
) {
    fun run() {
        val shape = directive.shape()
        val symbol = directive.symbol()
        val context = directive.context()

        // Collect enum members: works for both Smithy 2.0 enum shapes and
        // Smithy 1.0 string shapes with the deprecated @enum trait.
        data class EnumMember(val name: String, val wireValue: String, val docs: String?)

        val members: List<EnumMember> = if (shape.isEnumShape()) {
            val enumShape = directive.expectEnumShape()
            val wireValues = enumShape.enumValues
            enumShape.members().map { member ->
                EnumMember(
                    member.memberName,
                    wireValues[member.memberName] ?: member.memberName,
                    member.getTrait(DocumentationTrait::class.java)
                        .map { it.value }.orElse(null),
                )
            }
        } else {
            val enumTrait = shape.expectTrait(EnumTrait::class.java)
            enumTrait.values.map { definition ->
                EnumMember(
                    definition.name.orElse(definition.value),
                    definition.value,
                    definition.documentation.orElse(null),
                )
            }
        }

        context.writerDelegator().useShapeWriter(shape) { writer ->
            if (members.isNotEmpty()) {
                writer.importContainer.addImport("std", "std")
            }

            val docs = shape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            writer.writeDocs(docs)
            writer.openBlock("pub const \$L = enum {", symbol.name)

            for (member in members) {
                val variantName = NamingUtil.toFieldName(member.name)
                if (member.docs != null) {
                    writer.writeDocs(member.docs)
                }
                writer.write("\$L,", variantName)
            }

            // Emit json_field_names mapping Zig variant names to wire values.
            // Used by JSON runtime (parseEnum/writeEnum) and XML/query serialization.
            if (members.isNotEmpty()) {
                writer.blankLine()
                writer.openBlock("pub const json_field_names = .{")
                for (member in members) {
                    val variantName = NamingUtil.toFieldName(member.name)
                    writer.write(".\$L = \"\$L\",", variantName, member.wireValue)
                }
                writer.closeBlock("};")

                // wireName: convert enum variant to wire string
                writer.blankLine()
                writer.openBlock("pub fn wireName(self: @This()) []const u8 {")
                writer.openBlock("return switch (self) {")
                for (member in members) {
                    val variantName = NamingUtil.toFieldName(member.name)
                    writer.write(".\$L => \"\$L\",", variantName, member.wireValue)
                }
                writer.closeBlock("};")
                writer.closeBlock("}")

                // fromWireName: convert wire string to enum variant
                writer.blankLine()
                writer.openBlock("pub fn fromWireName(str: []const u8) ?@This() {")
                // inline for + stringToEnum each cost ~N branches per variant.
                // Zig's default comptime branch quota is 1000.
                val branchCost = members.size * 3 // inline for + eql + stringToEnum
                if (branchCost > 1000) {
                    writer.write("@setEvalBranchQuota(\$L);", branchCost + 100)
                }
                writer.openBlock("inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {")
                writer.openBlock("if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {")
                writer.write("return @field(@This(), field.name);")
                writer.closeBlock("}")
                writer.closeBlock("}")
                writer.write("return std.meta.stringToEnum(@This(), str);")
                writer.closeBlock("}")
            }

            writer.closeBlock("};")
        }
    }
}

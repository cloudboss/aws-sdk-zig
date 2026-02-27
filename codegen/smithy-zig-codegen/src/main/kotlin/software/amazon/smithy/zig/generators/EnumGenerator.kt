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
        data class EnumMember(val name: String, val docs: String?)

        val members: List<EnumMember> = if (shape.isEnumShape()) {
            val enumShape = directive.expectEnumShape()
            enumShape.members().map { member ->
                EnumMember(
                    member.memberName,
                    member.getTrait(DocumentationTrait::class.java)
                        .map { it.value }.orElse(null),
                )
            }
        } else {
            val enumTrait = shape.expectTrait(EnumTrait::class.java)
            enumTrait.values.map { definition ->
                EnumMember(
                    definition.name.orElse(definition.value),
                    definition.documentation.orElse(null),
                )
            }
        }

        context.writerDelegator().useShapeWriter(shape) { writer ->
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

            // Emit json_field_names for JSON protocol services
            if (isJsonProtocol(context)) {
                if (members.isNotEmpty()) {
                    writer.blankLine()
                    writer.openBlock("pub const json_field_names = .{")
                    for (member in members) {
                        val variantName = NamingUtil.toFieldName(member.name)
                        writer.write(".\$L = \"\$L\",", variantName, member.name)
                    }
                    writer.closeBlock("};");
                }
            }

            writer.closeBlock("};");
        }
    }

    private fun isJsonProtocol(context: ZigContext): Boolean {
        val service = context.service
        return service.hasTrait("aws.protocols#awsJson1_0") ||
            service.hasTrait("aws.protocols#awsJson1_1") ||
            service.hasTrait("aws.protocols#restJson1")
    }
}

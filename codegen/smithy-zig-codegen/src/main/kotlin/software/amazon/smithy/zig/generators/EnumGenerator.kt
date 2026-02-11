package software.amazon.smithy.zig.generators

import software.amazon.smithy.codegen.core.directed.GenerateEnumDirective
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings

class EnumGenerator(
    private val directive: GenerateEnumDirective<ZigContext, ZigSettings>,
) {
    fun run() {
        val shape = directive.expectEnumShape()
        val symbol = directive.symbol()
        val context = directive.context()

        context.writerDelegator().useShapeWriter(shape) { writer ->
            val docs = shape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            writer.writeDocs(docs)
            writer.openBlock("pub const \$L = enum {", symbol.name)

            for (member in shape.members()) {
                val variantName = NamingUtil.toFieldName(member.memberName)
                val memberDocs = member.getTrait(DocumentationTrait::class.java)
                    .map { it.value }
                    .orElse(null)

                if (memberDocs != null) {
                    writer.writeDocs(memberDocs)
                }
                writer.write("\$L,", variantName)
            }

            // Emit json_field_names for JSON protocol services
            if (isJsonProtocol(context)) {
                if (shape.members().isNotEmpty()) {
                    writer.blankLine()
                    writer.openBlock("pub const json_field_names = .{")
                    for (member in shape.members()) {
                        val variantName = NamingUtil.toFieldName(member.memberName)
                        writer.write(".\$L = \"\$L\",", variantName, member.memberName)
                    }
                    writer.closeBlock("};")
                }
            }

            writer.closeBlock("};")
        }
    }

    private fun isJsonProtocol(context: ZigContext): Boolean {
        val service = context.service
        return service.hasTrait("aws.protocols#awsJson1_0") ||
            service.hasTrait("aws.protocols#awsJson1_1") ||
            service.hasTrait("aws.protocols#restJson1")
    }
}

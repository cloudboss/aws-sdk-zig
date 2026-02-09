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

            writer.closeBlock("};")
        }
    }
}

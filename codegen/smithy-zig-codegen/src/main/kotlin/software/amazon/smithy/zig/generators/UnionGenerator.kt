package software.amazon.smithy.zig.generators

import software.amazon.smithy.codegen.core.directed.GenerateUnionDirective
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings

class UnionGenerator(
    private val directive: GenerateUnionDirective<ZigContext, ZigSettings>,
) {
    fun run() {
        val shape = directive.shape()
        val symbol = directive.symbol()
        val context = directive.context()
        val symbolProvider = directive.symbolProvider()

        context.writerDelegator().useShapeWriter(shape) { writer ->
            val docs = shape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            writer.writeDocs(docs)
            writer.openBlock("pub const \$L = union(enum) {", symbol.name)

            for (member in shape.members()) {
                val variantName = NamingUtil.toSnakeCase(member.memberName)
                val targetSymbol = symbolProvider.toSymbol(member)

                val memberDocs = member.getTrait(DocumentationTrait::class.java)
                    .map { it.value }
                    .orElse(null)

                if (memberDocs != null) {
                    writer.writeDocs(memberDocs)
                }
                writer.write("\$L: \$L,", variantName, targetSymbol.name)
            }

            writer.closeBlock("};")
        }
    }
}

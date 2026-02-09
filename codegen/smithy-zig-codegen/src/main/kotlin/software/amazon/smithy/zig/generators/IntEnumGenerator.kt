package software.amazon.smithy.zig.generators

import software.amazon.smithy.codegen.core.directed.GenerateIntEnumDirective
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings

class IntEnumGenerator(
    private val directive: GenerateIntEnumDirective<ZigContext, ZigSettings>,
) {
    fun run() {
        val shape = directive.expectIntEnumShape()
        val symbol = directive.symbol()
        val context = directive.context()

        context.writerDelegator().useShapeWriter(shape) { writer ->
            val docs = shape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            writer.writeDocs(docs)
            writer.openBlock("pub const \$L = enum(i32) {", symbol.name)

            for ((name, value) in shape.enumValues) {
                val variantName = NamingUtil.toFieldName(name)
                writer.write("\$L = \$L,", variantName, value)
            }

            writer.closeBlock("};")
        }
    }
}

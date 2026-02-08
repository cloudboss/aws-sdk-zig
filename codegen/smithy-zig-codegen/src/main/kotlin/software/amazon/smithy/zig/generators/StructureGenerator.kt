package software.amazon.smithy.zig.generators

import software.amazon.smithy.codegen.core.Symbol
import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.codegen.core.directed.GenerateStructureDirective
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings

class StructureGenerator(
    private val context: ZigContext,
    private val shape: StructureShape,
    private val symbolProvider: SymbolProvider,
    private val symbol: Symbol,
) {
    constructor(directive: GenerateStructureDirective<ZigContext, ZigSettings>) : this(
        directive.context(),
        directive.shape(),
        directive.symbolProvider(),
        directive.symbol(),
    )

    fun run() {
        context.writerDelegator().useShapeWriter(shape) { writer ->
            val docs = shape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            writer.writeDocs(docs)
            writer.openBlock("pub const \$L = struct {", symbol.name)

            val members = shape.allMembers
            var firstField = true
            for ((memberName, memberShape) in members) {
                val fieldName = NamingUtil.toSnakeCase(memberName)
                val memberSymbol = symbolProvider.toSymbol(memberShape)

                val memberDocs = memberShape.getTrait(DocumentationTrait::class.java)
                    .map { it.value }
                    .orElse(null)

                writer.writeField(fieldName, memberSymbol.name, memberDocs, blankBefore = !firstField)
                firstField = false
            }

            writer.closeBlock("};")
        }
    }
}

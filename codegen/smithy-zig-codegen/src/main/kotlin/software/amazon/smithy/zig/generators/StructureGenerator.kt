package software.amazon.smithy.zig.generators

import software.amazon.smithy.codegen.core.Symbol
import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.codegen.core.directed.GenerateStructureDirective
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings

class StructureGenerator private constructor(
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

    constructor(
        context: ZigContext,
        shape: StructureShape,
        symbolProvider: SymbolProvider,
        symbol: Symbol,
    ) : this(
        context = context,
        shape = shape,
        symbolProvider = symbolProvider,
        symbol = symbol,
    )

    fun run() {
        context.writerDelegator().useShapeWriter(shape) { writer ->
            val docs = shape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            writer.writeDocs(docs)
            writer.openBlock("pub const \$L = struct {", symbol.name)

            // Generate fields
            val members = shape.allMembers
            for ((memberName, memberShape) in members) {
                val fieldName = NamingUtil.toSnakeCase(memberName)
                val memberSymbol = symbolProvider.toSymbol(memberShape)

                val memberDocs = memberShape.getTrait(DocumentationTrait::class.java)
                    .map { it.value }
                    .orElse(null)

                writer.writeField(fieldName, memberSymbol.name, memberDocs)
            }

            // Write allocator field and deinit if there are any slice/pointer fields
            if (hasAllocatableFields()) {
                writer.write("")
                writer.write("allocator: std.mem.Allocator,")
                writer.write("")
                writer.openBlock("pub fn deinit(self: *const \$L) void {", symbol.name)
                writer.write("_ = self;")
                writer.closeBlock("}")
            }

            writer.closeBlock("};")
        }
    }

    private fun hasAllocatableFields(): Boolean {
        return shape.allMembers.values.any { member ->
            val sym = symbolProvider.toSymbol(member)
            sym.name.startsWith("[]") || sym.name.startsWith("?[]")
        }
    }
}

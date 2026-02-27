package software.amazon.smithy.zig.generators

import software.amazon.smithy.codegen.core.Symbol
import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MapShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.codegen.core.directed.GenerateStructureDirective
import software.amazon.smithy.zig.DefaultValueUtil
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings

class StructureGenerator(
    private val context: ZigContext,
    private val shape: StructureShape,
    private val symbolProvider: SymbolProvider,
    private val symbol: Symbol,
    private val model: Model,
) {
    constructor(directive: GenerateStructureDirective<ZigContext, ZigSettings>) : this(
        directive.context(),
        directive.shape(),
        directive.symbolProvider(),
        directive.symbol(),
        directive.model(),
    )

    fun run() {
        context.writerDelegator().useShapeWriter(shape) { writer ->
            // Import aws runtime if any member transitively uses map types
            fun containsMap(target: software.amazon.smithy.model.shapes.Shape): Boolean {
                return when (target) {
                    is MapShape -> true
                    is ListShape -> containsMap(model.expectShape(target.member.target))
                    else -> false
                }
            }
            val hasMapMembers = shape.allMembers.values.any { member ->
                containsMap(model.expectShape(member.target))
            }
            if (hasMapMembers) {
                writer.write("const aws = @import(\"aws\");")
                writer.blankLine()
            }

            // Import referenced named types (enums, structs, unions)
            val referencedTypes = collectReferencedNamedTypes()
            for (typeName in referencedTypes) {
                val fileName = NamingUtil.toZigFileName(typeName)
                writer.write("const \$L = @import(\"\$L\").\$L;", typeName, fileName, typeName)
            }
            if (referencedTypes.isNotEmpty()) {
                writer.blankLine()
            }

            val docs = shape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            writer.writeDocs(docs)
            writer.openBlock("pub const \$L = struct {", symbol.name)

            val members = shape.allMembers
            var firstField = true
            for ((memberName, memberShape) in members) {
                val fieldName = NamingUtil.toFieldName(memberName)
                val memberSymbol = symbolProvider.toSymbol(memberShape)

                val memberDocs = memberShape.getTrait(DocumentationTrait::class.java)
                    .map { it.value }
                    .orElse(null)

                val defaultValue = DefaultValueUtil.resolveDefaultValue(memberShape, model, symbolProvider)
                val zigType = defaultValue?.typeName ?: memberSymbol.name
                val defaultSuffix = defaultValue?.let { " = ${it.literal}" } ?: ""

                if (!firstField) {
                    writer.blankLine()
                }
                if (memberDocs != null) {
                    writer.writeDocs(memberDocs)
                }
                writer.write("\$L: \$L\$L,", fieldName, zigType, defaultSuffix)
                firstField = false
            }

            // Emit json_field_names for JSON protocol services
            if (isJsonProtocol()) {
                writeJsonFieldNames(writer)
            }

            writer.closeBlock("};")
        }
    }

    private fun isJsonProtocol(): Boolean {
        val service = context.service
        return service.hasTrait("aws.protocols#awsJson1_0") ||
            service.hasTrait("aws.protocols#awsJson1_1") ||
            service.hasTrait("aws.protocols#restJson1")
    }

    private fun writeJsonFieldNames(writer: software.amazon.smithy.zig.ZigWriter) {
        val members = shape.allMembers
        if (members.isEmpty()) return

        writer.blankLine()
        writer.openBlock("pub const json_field_names = .{")
        for ((memberName, _) in members) {
            val fieldName = NamingUtil.toFieldName(memberName)
            writer.write(".\$L = \"\$L\",", fieldName, memberName)
        }
        writer.closeBlock("};")
    }

    /**
     * Collect type names of named shapes (enums, structs, unions) referenced by members,
     * excluding the current shape itself. Recurses through list elements and map values
     * to find nested named types.
     */
    private fun collectReferencedNamedTypes(): Set<String> {
        val result = mutableSetOf<String>()

        fun collectFromShape(targetShape: software.amazon.smithy.model.shapes.Shape) {
            when (targetShape) {
                is StructureShape -> result.add(targetShape.id.name)
                is EnumShape -> result.add(targetShape.id.name)
                is IntEnumShape -> result.add(targetShape.id.name)
                is UnionShape -> result.add(targetShape.id.name)
                is ListShape -> collectFromShape(model.expectShape(targetShape.member.target))
                is MapShape -> collectFromShape(model.expectShape(targetShape.value.target))
                is software.amazon.smithy.model.shapes.StringShape -> {
                    if (targetShape.hasTrait(EnumTrait::class.java)) {
                        result.add(targetShape.id.name)
                    }
                }
            }
        }

        for ((_, memberShape) in shape.allMembers) {
            collectFromShape(model.expectShape(memberShape.target))
        }

        // Don't import ourselves
        result.remove(shape.id.name)

        return result
    }
}

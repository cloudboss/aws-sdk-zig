package software.amazon.smithy.zig.generators

import software.amazon.smithy.codegen.core.directed.GenerateUnionDirective
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MapShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.model.traits.ErrorTrait
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
        val model = directive.model()

        context.writerDelegator().useShapeWriter(shape) { writer ->
            // Import aws runtime if any member transitively uses map types
            fun containsMap(target: software.amazon.smithy.model.shapes.Shape): Boolean {
                return when (target) {
                    is MapShape -> true
                    is ListShape -> containsMap(model.expectShape(target.member.target))
                    else -> false
                }
            }
            val hasMapMembers = shape.members().any { member ->
                containsMap(model.expectShape(member.target))
            }
            if (hasMapMembers) {
                writer.write("const aws = @import(\"aws\");")
                writer.blankLine()
            }

            // Import referenced named types (enums, structs, unions)
            // Recurses through list elements and map values to find nested named types.
            val referencedTypes = mutableSetOf<software.amazon.smithy.model.shapes.Shape>()
            fun collectFromShape(targetShape: software.amazon.smithy.model.shapes.Shape) {
                when (targetShape) {
                    is StructureShape -> referencedTypes.add(targetShape)
                    is EnumShape -> referencedTypes.add(targetShape)
                    is IntEnumShape -> referencedTypes.add(targetShape)
                    is UnionShape -> referencedTypes.add(targetShape)
                    is ListShape -> collectFromShape(model.expectShape(targetShape.member.target))
                    is MapShape -> collectFromShape(model.expectShape(targetShape.value.target))
                    is software.amazon.smithy.model.shapes.StringShape -> {
                        if (targetShape.hasTrait(EnumTrait::class.java)) {
                            referencedTypes.add(targetShape)
                        }
                    }
                }
            }
            for (member in shape.members()) {
                collectFromShape(model.expectShape(member.target))
            }
            referencedTypes.removeIf { it.id == shape.id }

            for (typeShape in referencedTypes) {
                val typeName = typeShape.id.name
                if (typeShape.hasTrait(ErrorTrait::class.java)) {
                    writer.write("const \$L = @import(\"errors.zig\").\$L;", typeName, typeName)
                } else {
                    val fileName = NamingUtil.toZigFileName(typeName)
                    writer.write("const \$L = @import(\"\$L\").\$L;", typeName, fileName, typeName)
                }
            }
            if (referencedTypes.isNotEmpty()) {
                writer.blankLine()
            }

            val docs = shape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            writer.writeDocs(docs)
            writer.openBlock("pub const \$L = union(enum) {", symbol.name)

            for (member in shape.members()) {
                val variantName = NamingUtil.toFieldName(member.memberName)
                val targetSymbol = symbolProvider.toSymbol(member)

                val memberDocs = member.getTrait(DocumentationTrait::class.java)
                    .map { it.value }
                    .orElse(null)

                if (memberDocs != null) {
                    writer.writeDocs(memberDocs)
                }
                writer.write("\$L: \$L,", variantName, targetSymbol.name)
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

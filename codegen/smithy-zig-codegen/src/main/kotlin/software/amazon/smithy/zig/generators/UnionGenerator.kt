package software.amazon.smithy.zig.generators

import software.amazon.smithy.codegen.core.directed.GenerateUnionDirective
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.model.traits.EnumTrait
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
            // Import referenced named types (enums, structs, unions)
            val referencedTypes = mutableSetOf<String>()
            for (member in shape.members()) {
                val targetShape = model.expectShape(member.target)
                when (targetShape) {
                    is StructureShape -> referencedTypes.add(targetShape.id.name)
                    is EnumShape -> referencedTypes.add(targetShape.id.name)
                    is IntEnumShape -> referencedTypes.add(targetShape.id.name)
                    is UnionShape -> referencedTypes.add(targetShape.id.name)
                    is ListShape -> {
                        val listTarget = model.expectShape(targetShape.member.target)
                        when (listTarget) {
                            is StructureShape -> referencedTypes.add(listTarget.id.name)
                            is EnumShape -> referencedTypes.add(listTarget.id.name)
                            is IntEnumShape -> referencedTypes.add(listTarget.id.name)
                            is UnionShape -> referencedTypes.add(listTarget.id.name)
                        }
                    }
                }
                if (targetShape is software.amazon.smithy.model.shapes.StringShape &&
                    targetShape.hasTrait(EnumTrait::class.java)) {
                    referencedTypes.add(targetShape.id.name)
                }
            }
            referencedTypes.remove(shape.id.name)

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

            writer.closeBlock("};")
        }
    }
}

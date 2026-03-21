package software.amazon.smithy.zig

import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.node.ArrayNode
import software.amazon.smithy.model.node.BooleanNode
import software.amazon.smithy.model.node.Node
import software.amazon.smithy.model.node.NullNode
import software.amazon.smithy.model.node.NumberNode
import software.amazon.smithy.model.node.StringNode
import software.amazon.smithy.model.shapes.BlobShape
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.traits.DefaultTrait
import software.amazon.smithy.model.traits.EnumTrait

object DefaultValueUtil {
    data class DefaultValue(
        val typeName: String,
        val literal: String,
    )

    fun resolveDefaultValue(
        memberShape: MemberShape,
        model: Model,
        symbolProvider: SymbolProvider,
    ): DefaultValue? {
        if (!memberShape.hasTrait(DefaultTrait::class.java)) return null

        val node = memberShape.getTrait(DefaultTrait::class.java).get().toNode()
        val targetShape = model.expectShape(memberShape.target)
        if (node is StringNode && targetShape is BlobShape) return null
        val literal = nodeToZigLiteral(node, targetShape) ?: return null
        val typeName = symbolProvider.toSymbol(targetShape).name

        return DefaultValue(typeName = typeName, literal = literal)
    }

    private fun nodeToZigLiteral(node: Node, targetShape: software.amazon.smithy.model.shapes.Shape): String? {
        return when (node) {
            is BooleanNode -> if (node.value) "true" else "false"
            is NumberNode -> node.value.toString()
            is StringNode -> enumLiteralForDefault(node, targetShape) ?: "\"${escapeString(node.value)}\""
            is ArrayNode -> if (node.elements.isEmpty()) "&.{}" else null
            is NullNode -> null
            else -> null
        }
    }

    private fun enumLiteralForDefault(node: StringNode, targetShape: software.amazon.smithy.model.shapes.Shape): String? {
        if (targetShape is EnumShape) {
            val match = targetShape.members().firstOrNull { member ->
                targetShape.enumValues[member.memberName] == node.value
            } ?: return null
            return ".${NamingUtil.toFieldName(match.memberName)}"
        }

        if (targetShape is StringShape && targetShape.hasTrait(EnumTrait::class.java)) {
            val enumTrait = targetShape.expectTrait(EnumTrait::class.java)
            val match = enumTrait.values.firstOrNull { def -> def.value == node.value } ?: return null
            return ".${NamingUtil.toFieldName(match.name.orElse(match.value))}"
        }

        return null
    }

    private fun escapeString(value: String): String {
        val builder = StringBuilder()
        for (ch in value) {
            when (ch) {
                '\\' -> builder.append("\\\\")
                '"' -> builder.append("\\\"")
                '\n' -> builder.append("\\n")
                '\r' -> builder.append("\\r")
                '\t' -> builder.append("\\t")
                else -> {
                    val code = ch.code
                    if (code < 0x20 || code > 0x7e) {
                        builder.append("\\x")
                        builder.append(code.toString(16).padStart(2, '0'))
                    } else {
                        builder.append(ch)
                    }
                }
            }
        }
        return builder.toString()
    }
}

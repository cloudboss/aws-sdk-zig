package software.amazon.smithy.zig

import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.node.ArrayNode
import software.amazon.smithy.model.node.BooleanNode
import software.amazon.smithy.model.node.Node
import software.amazon.smithy.model.node.NullNode
import software.amazon.smithy.model.node.NumberNode
import software.amazon.smithy.model.node.StringNode
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.traits.DefaultTrait

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
        val literal = nodeToZigLiteral(node) ?: return null
        val typeName = symbolProvider.toSymbol(model.expectShape(memberShape.target)).name

        return DefaultValue(typeName = typeName, literal = literal)
    }

    private fun nodeToZigLiteral(node: Node): String? {
        return when (node) {
            is BooleanNode -> if (node.value) "true" else "false"
            is NumberNode -> node.value.toString()
            is StringNode -> "\"${escapeString(node.value)}\""
            is ArrayNode -> if (node.elements.isEmpty()) "&.{}" else null
            is NullNode -> null
            else -> null
        }
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

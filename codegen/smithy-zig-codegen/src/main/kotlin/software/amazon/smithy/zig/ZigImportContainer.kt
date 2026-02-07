package software.amazon.smithy.zig

import software.amazon.smithy.codegen.core.ImportContainer
import software.amazon.smithy.codegen.core.Symbol

class ZigImportContainer : ImportContainer {
    private val imports = mutableMapOf<String, String>()

    override fun importSymbol(symbol: Symbol, alias: String) {
        val namespace = symbol.namespace
        if (namespace.isNotEmpty()) {
            imports[alias] = namespace
        }
    }

    fun addImport(name: String, module: String) {
        imports[name] = module
    }

    override fun toString(): String {
        if (imports.isEmpty()) return ""
        return imports.entries
            .sortedBy { it.key }
            .joinToString("\n") { (alias, module) ->
                "const $alias = @import(\"$module\");"
            } + "\n"
    }
}

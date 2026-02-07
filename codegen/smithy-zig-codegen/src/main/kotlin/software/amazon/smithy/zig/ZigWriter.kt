package software.amazon.smithy.zig

import software.amazon.smithy.codegen.core.SymbolWriter

class ZigWriter(private val fileName: String) :
    SymbolWriter<ZigWriter, ZigImportContainer>(ZigImportContainer()) {

    init {
        indentText = "    "
        trimTrailingSpaces()
    }

    fun blankLine() {
        write("")
    }

    fun writeDocs(docs: String?) {
        val lines = DocConverter.convert(docs)
        for (line in lines) {
            if (line.isEmpty()) {
                write("///")
            } else {
                write("/// \$L", line)
            }
        }
    }

    fun writeField(name: String, type: String, docs: String? = null, blankBefore: Boolean = false) {
        if (blankBefore) {
            blankLine()
        }
        if (docs != null) {
            writeDocs(docs)
        }
        write("\$L: \$L,", name, type)
    }

    override fun toString(): String {
        val imports = importContainer.toString()
        val body = super.toString()
        return if (imports.isEmpty()) {
            body
        } else {
            imports + "\n" + body
        }
    }

    companion object {
        fun factory(): SymbolWriter.Factory<ZigWriter> {
            return SymbolWriter.Factory { fileName, _namespace ->
                ZigWriter(fileName)
            }
        }
    }
}

package software.amazon.smithy.zig

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

class DocConverterTest {
    @Test
    fun plainText() {
        val result = DocConverter.convert("Hello world")
        assertEquals(listOf("Hello world"), result)
    }

    @Test
    fun codeTag() {
        val result = DocConverter.convert("Use <code>foo</code> here")
        assertEquals(listOf("Use `foo` here"), result)
    }

    @Test
    fun htmlTagStripping() {
        val result = DocConverter.convert("<b>bold</b> and <i>italic</i>")
        assertEquals(listOf("bold and italic"), result)
    }

    @Test
    fun entityDecoding() {
        val result = DocConverter.convert("A &amp; B &lt; C &gt; D")
        assertEquals(listOf("A & B < C > D"), result)
    }

    @Test
    fun nullInput() {
        val result = DocConverter.convert(null)
        assertEquals(emptyList<String>(), result)
    }

    @Test
    fun blankInput() {
        val result = DocConverter.convert("   ")
        assertEquals(emptyList<String>(), result)
    }

    @Test
    fun wordWrapping() {
        val longText = "This is a very long line that should be wrapped because " +
            "it exceeds the maximum width of seventy-six characters in total length"
        val result = DocConverter.convert(longText)
        for (line in result) {
            assert(line.length <= 80) { "Line too long: ${line.length}" }
        }
        assert(result.size > 1) { "Should wrap into multiple lines" }
    }

    @Test
    fun paragraphs() {
        val result = DocConverter.convert("<p>First para</p><p>Second para</p>")
        assert(result.contains("")) { "Should have blank line between paragraphs" }
    }
}

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
    fun boldTag() {
        val result = DocConverter.convert("<b>bold</b> and <strong>strong</strong>")
        assertEquals(listOf("**bold** and **strong**"), result)
    }

    @Test
    fun italicTag() {
        val result = DocConverter.convert("<i>italic</i> and <em>emphasis</em>")
        assertEquals(listOf("*italic* and *emphasis*"), result)
    }

    @Test
    fun linkTag() {
        val result = DocConverter.convert("""See <a href="https://example.com">the docs</a> for details""")
        assertEquals(listOf("See [the docs](https://example.com) for details"), result)
    }

    @Test
    fun unorderedList() {
        val result = DocConverter.convert("<ul><li>first</li><li>second</li><li>third</li></ul>")
        assertEquals(listOf("* first", "* second", "* third"), result)
    }

    @Test
    fun namedEntityDecoding() {
        val result = DocConverter.convert("A &amp; B &lt; C &gt; D &quot;E&quot;")
        assertEquals(listOf("A & B < C > D \"E\""), result)
    }

    @Test
    fun numericEntityDecoding() {
        val result = DocConverter.convert("&#60;div&#62; and &#x27;quote&#x27;")
        assertEquals(listOf("<div> and 'quote'"), result)
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

    @Test
    fun preCodeBlock() {
        val result = DocConverter.convert(
            "<p>Example:</p><pre><code>const x = 42;\nconst y = x + 1;</code></pre>"
        )
        assertEquals(
            listOf("Example:", "", "```", "const x = 42;", "const y = x + 1;", "```"),
            result
        )
    }

    @Test
    fun preBlockEntities() {
        val result = DocConverter.convert(
            "<pre>if (a &lt; b &amp;&amp; c &gt; d) {}</pre>"
        )
        assertEquals(listOf("```", "if (a < b && c > d) {}", "```"), result)
    }

    @Test
    fun preBlockLiteralAmpEntity() {
        // Code block should display the literal text: &amp;
        // HTML source double-encodes it as &amp;amp;
        val result = DocConverter.convert("<pre>&amp;amp;</pre>")
        assertEquals(listOf("```", "&amp;", "```"), result)
    }

    @Test
    fun preBlockLiteralLtEntity() {
        // Code block should display the literal text: &lt;
        // HTML source double-encodes it as &amp;lt;
        val result = DocConverter.convert("<pre>&amp;lt;</pre>")
        assertEquals(listOf("```", "&lt;", "```"), result)
    }

    @Test
    fun preBlockLiteralNumericEntity() {
        // Code block should display the literal text: &#60;
        // HTML source double-encodes it as &amp;#60;
        val result = DocConverter.convert("<pre>&amp;#60;</pre>")
        assertEquals(listOf("```", "&#60;", "```"), result)
    }

    @Test
    fun preBlockMixedEntityDepths() {
        // Mix of single-encoded (should decode) and double-encoded (should stay as entity)
        val result = DocConverter.convert("<pre>&lt;div class=&amp;quot;foo&amp;quot;&gt;</pre>")
        assertEquals(listOf("```", "<div class=&quot;foo&quot;>", "```"), result)
    }

    @Test
    fun textDoubleEncodedAmp() {
        val result = DocConverter.convert("Use &amp;amp; for ampersands")
        assertEquals(listOf("Use &amp; for ampersands"), result)
    }

    @Test
    fun textDoubleEncodedLt() {
        val result = DocConverter.convert("Use &amp;lt; for less-than")
        assertEquals(listOf("Use &lt; for less-than"), result)
    }

    @Test
    fun textDoubleEncodedNumeric() {
        val result = DocConverter.convert("Use &amp;#60; for less-than")
        assertEquals(listOf("Use &#60; for less-than"), result)
    }

    @Test
    fun preBlockWithoutCodeTag() {
        val result = DocConverter.convert(
            "<pre>line one\nline two</pre>"
        )
        assertEquals(listOf("```", "line one", "line two", "```"), result)
    }

    @Test
    fun noteTag() {
        val result = DocConverter.convert("<note>This is important info.</note>")
        assertEquals(listOf("**Note:** This is important info."), result)
    }

    @Test
    fun importantTag() {
        val result = DocConverter.convert("<important>Do not skip this.</important>")
        assertEquals(listOf("**Important:** Do not skip this."), result)
    }

    @Test
    fun definitionList() {
        val result = DocConverter.convert("<dl><dt>Term</dt><dd>Definition here</dd></dl>")
        assert(result.any { it.contains("**Term**") }) { "Should bold the term" }
        assert(result.any { it.contains("Definition here") }) { "Should include the definition" }
    }

    @Test
    fun mixedFormatting() {
        val result = DocConverter.convert(
            "<p>Use <code>getCallerIdentity</code> to retrieve the <b>IAM</b> " +
            "user or <i>role</i> details.</p>"
        )
        assertEquals(
            listOf("Use `getCallerIdentity` to retrieve the **IAM** user or *role* details."),
            result
        )
    }

    @Test
    fun listItemWrapping() {
        val result = DocConverter.convert(
            "<ul><li>This is a very long list item that should be wrapped because " +
            "it exceeds the maximum width of seventy-six characters in total</li></ul>"
        )
        assert(result.size > 1) { "Should wrap into multiple lines" }
        assert(result[0].startsWith("* ")) { "First line should start with bullet" }
        if (result.size > 1) {
            assert(result[1].startsWith("  ")) { "Continuation should be indented" }
        }
    }
}

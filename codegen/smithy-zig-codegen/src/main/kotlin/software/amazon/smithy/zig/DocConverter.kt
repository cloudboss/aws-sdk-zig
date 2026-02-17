package software.amazon.smithy.zig

object DocConverter {
    private const val WRAP_WIDTH = 76
    private const val CODEBLOCK_MARKER = "\u0000CODEBLOCK_"

    private val NAMED_ENTITIES = mapOf(
        "amp" to "&",
        "lt" to "<",
        "gt" to ">",
        "quot" to "\"",
        "apos" to "'",
        "nbsp" to " ",
        "ndash" to "\u2013",
        "mdash" to "\u2014",
        "lsquo" to "\u2018",
        "rsquo" to "\u2019",
        "ldquo" to "\u201C",
        "rdquo" to "\u201D",
        "bull" to "\u2022",
        "hellip" to "\u2026",
        "copy" to "\u00A9",
        "reg" to "\u00AE",
        "trade" to "\u2122",
    )

    private val ENTITY_PATTERN = Regex("&(#x[0-9a-fA-F]+|#[0-9]+|[a-zA-Z]+);")

    /** Decode all HTML entities in a single pass to avoid double-decoding. */
    private fun decodeEntities(text: String): String {
        return ENTITY_PATTERN.replace(text) { match ->
            val ref = match.groupValues[1]
            when {
                ref.startsWith("#x") -> {
                    val cp = ref.substring(2).toIntOrNull(16)
                    if (cp != null) String(Character.toChars(cp)) else match.value
                }
                ref.startsWith("#") -> {
                    val cp = ref.substring(1).toIntOrNull()
                    if (cp != null) String(Character.toChars(cp)) else match.value
                }
                else -> NAMED_ENTITIES[ref] ?: match.value
            }
        }
    }

    fun convert(html: String?): List<String> {
        if (html.isNullOrBlank()) return emptyList()

        // Extract <pre> blocks before general processing to preserve their whitespace
        val codeBlocks = mutableListOf<String>()
        var processed = Regex(
            "<pre>\\s*(?:<code>)?(.*?)(?:</code>)?\\s*</pre>",
            setOf(RegexOption.DOT_MATCHES_ALL, RegexOption.IGNORE_CASE)
        ).replace(html) { match ->
            val index = codeBlocks.size
            val code = decodeEntities(match.groupValues[1])
                .trimEnd()
                .trimIndent()
            codeBlocks.add(code)
            "\n\n${CODEBLOCK_MARKER}${index}\n\n"
        }

        val text = processed
            // Inline code
            .replace(Regex("<code>(.*?)</code>", RegexOption.DOT_MATCHES_ALL), "`$1`")
            // Bold
            .replace(Regex("<b>(.*?)</b>", RegexOption.DOT_MATCHES_ALL), "**$1**")
            .replace(Regex("<strong>(.*?)</strong>", RegexOption.DOT_MATCHES_ALL), "**$1**")
            // Italic
            .replace(Regex("<i>(.*?)</i>", RegexOption.DOT_MATCHES_ALL), "*$1*")
            .replace(Regex("<em>(.*?)</em>", RegexOption.DOT_MATCHES_ALL), "*$1*")
            // Links
            .replace(Regex("<a\\s+[^>]*href=\"([^\"]+)\"[^>]*>(.*?)</a>", RegexOption.DOT_MATCHES_ALL), "[$2]($1)")
            // Paragraphs
            .replace(Regex("<p>", RegexOption.IGNORE_CASE), "\n\n")
            .replace(Regex("</p>", RegexOption.IGNORE_CASE), "")
            // Line breaks
            .replace(Regex("<br\\s*/?>", RegexOption.IGNORE_CASE), "\n")
            // Lists
            .replace(Regex("<li>\\s*", RegexOption.IGNORE_CASE), "\n* ")
            .replace(Regex("</li>", RegexOption.IGNORE_CASE), "")
            .replace(Regex("</?[ou]l>", RegexOption.IGNORE_CASE), "\n")
            // Definition lists
            .replace(Regex("<dt>(.*?)</dt>", RegexOption.DOT_MATCHES_ALL), "\n**$1** ")
            .replace(Regex("<dd>(.*?)</dd>", RegexOption.DOT_MATCHES_ALL), "$1\n")
            .replace(Regex("</?dl>", RegexOption.IGNORE_CASE), "\n")
            // AWS-specific callout tags
            .replace(Regex("<note>", RegexOption.IGNORE_CASE), "\n\n**Note:** ")
            .replace(Regex("</note>", RegexOption.IGNORE_CASE), "")
            .replace(Regex("<important>", RegexOption.IGNORE_CASE), "\n\n**Important:** ")
            .replace(Regex("</important>", RegexOption.IGNORE_CASE), "")
            // Strip remaining HTML tags
            .replace(Regex("<[^>]+>"), "")
            // Collapse horizontal whitespace (preserve newlines)
            .replace(Regex("[ \\t]+"), " ")

        // Decode entities after all tag processing (single pass, no double-decoding)
        val decoded = decodeEntities(text).trim()

        if (decoded.isEmpty()) return emptyList()

        val lines = mutableListOf<String>()
        for (paragraph in decoded.split(Regex("\n\\s*\n"))) {
            val trimmed = paragraph.trim()
            if (trimmed.isEmpty()) continue
            
            // Skip bare callout tags with no content (e.g., "**Note:**" or "**Important:**" alone)
            if (trimmed.matches(Regex("^\\*\\*(Note|Important):\\*\\*\\s*$"))) continue
            
            if (lines.isNotEmpty()) {
                lines.add("")
            }

            // Check for code block placeholder
            val markerMatch = Regex("^${Regex.escape(CODEBLOCK_MARKER)}(\\d+)$").find(trimmed)
            if (markerMatch != null) {
                val index = markerMatch.groupValues[1].toInt()
                lines.add("```")
                for (codeLine in codeBlocks[index].split("\n")) {
                    lines.add(codeLine)
                }
                lines.add("```")
            } else {
                lines.addAll(wordWrap(trimmed))
            }
        }
        return lines
    }

    private fun wordWrap(text: String): List<String> {
        val lines = mutableListOf<String>()
        for (inputLine in text.split("\n")) {
            val trimmed = inputLine.trim()
            if (trimmed.isEmpty()) continue

            // Detect list item prefix for continuation indent
            val continuationIndent = if (trimmed.startsWith("* ")) "  " else ""

            if (trimmed.length <= WRAP_WIDTH) {
                lines.add(trimmed)
                continue
            }
            var remaining = trimmed
            var first = true
            while (remaining.length > (if (first) WRAP_WIDTH else WRAP_WIDTH - continuationIndent.length)) {
                val effectiveWidth = if (first) WRAP_WIDTH else WRAP_WIDTH - continuationIndent.length
                val breakAt = remaining.lastIndexOf(' ', effectiveWidth)
                if (breakAt <= 0) {
                    // No space found -- take the whole thing
                    break
                }
                val prefix = if (first) "" else continuationIndent
                lines.add(prefix + remaining.substring(0, breakAt))
                remaining = remaining.substring(breakAt + 1)
                first = false
            }
            val prefix = if (first) "" else continuationIndent
            lines.add(prefix + remaining)
        }
        return lines
    }
}

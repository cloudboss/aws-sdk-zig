package software.amazon.smithy.zig

object DocConverter {
    private const val WRAP_WIDTH = 76

    fun convert(html: String?): List<String> {
        if (html.isNullOrBlank()) return emptyList()

        val text = html
            .replace(Regex("<code>(.*?)</code>", RegexOption.DOT_MATCHES_ALL), "`$1`")
            .replace(Regex("<a\\s+[^>]*href=\"([^\"]+)\"[^>]*>(.*?)</a>", RegexOption.DOT_MATCHES_ALL), "$2 ($1)")
            .replace(Regex("<p>", RegexOption.IGNORE_CASE), "\n\n")
            .replace(Regex("</p>", RegexOption.IGNORE_CASE), "")
            .replace(Regex("<br\\s*/?>", RegexOption.IGNORE_CASE), "\n")
            .replace(Regex("<[^>]+>"), "")
            .replace("&amp;", "&")
            .replace("&lt;", "<")
            .replace("&gt;", ">")
            .replace("&quot;", "\"")
            .replace("&#39;", "'")
            .replace("&nbsp;", " ")
            .replace(Regex("[ \\t]+"), " ")
            .trim()

        if (text.isEmpty()) return emptyList()

        val lines = mutableListOf<String>()
        for (paragraph in text.split(Regex("\n\\s*\n"))) {
            val trimmed = paragraph.trim()
            if (trimmed.isEmpty()) continue
            if (lines.isNotEmpty()) {
                lines.add("")
            }
            lines.addAll(wordWrap(trimmed))
        }
        return lines
    }

    private fun wordWrap(text: String): List<String> {
        val lines = mutableListOf<String>()
        for (inputLine in text.split("\n")) {
            val trimmed = inputLine.trim()
            if (trimmed.length <= WRAP_WIDTH) {
                lines.add(trimmed)
                continue
            }
            var remaining = trimmed
            while (remaining.length > WRAP_WIDTH) {
                val breakAt = remaining.lastIndexOf(' ', WRAP_WIDTH)
                if (breakAt <= 0) {
                    // No space found -- take the whole thing
                    break
                }
                lines.add(remaining.substring(0, breakAt))
                remaining = remaining.substring(breakAt + 1)
            }
            lines.add(remaining)
        }
        return lines
    }
}

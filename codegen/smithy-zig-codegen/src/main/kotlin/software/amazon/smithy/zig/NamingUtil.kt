package software.amazon.smithy.zig

object NamingUtil {
    fun toSnakeCase(name: String): String {
        if (name.isEmpty()) return name

        val result = StringBuilder()

        var i = 0
        while (i < name.length) {
            val c = name[i]

            if (c == '_' || c == '-') {
                if (result.isNotEmpty() && result.last() != '_') {
                    result.append('_')
                }
                i++
                continue
            }

            if (c.isUpperCase()) {
                // Count consecutive uppercase chars
                var upperEnd = i
                while (upperEnd < name.length && name[upperEnd].isUpperCase()) {
                    upperEnd++
                }
                val upperLen = upperEnd - i

                if (upperLen == 1) {
                    // Single uppercase: start of camelCase word
                    if (result.isNotEmpty() && result.last() != '_') {
                        result.append('_')
                    }
                    result.append(c.lowercaseChar())
                } else {
                    // Multiple uppercase: acronym
                    // If followed by lowercase, the last uppercase starts the next word
                    val acronymEnd = if (upperEnd < name.length && name[upperEnd].isLowerCase()) {
                        upperEnd - 1
                    } else {
                        upperEnd
                    }

                    if (result.isNotEmpty() && result.last() != '_') {
                        result.append('_')
                    }
                    for (j in i until acronymEnd) {
                        result.append(name[j].lowercaseChar())
                    }

                    // Include trailing digits as part of the acronym (e.g. EC2)
                    var digitEnd = acronymEnd
                    while (digitEnd < name.length && name[digitEnd].isDigit()) {
                        result.append(name[digitEnd])
                        digitEnd++
                    }

                    // If the last uppercase char starts a new word (followed by lowercase),
                    // don't consume it here -- let the next iteration handle it
                    i = digitEnd
                    continue
                }
            } else if (c.isDigit()) {
                // If transitioning from non-digit to digit, add underscore
                // BUT NOT if the previous char is uppercase (e.g., V2, EC2 -- part of acronym)
                if (i > 0 && result.isNotEmpty() && result.last() != '_' &&
                    !name[i - 1].isDigit() && name[i - 1] != '_' && name[i - 1] != '-' &&
                    !name[i - 1].isUpperCase()
                ) {
                    result.append('_')
                }
                result.append(c)
            } else {
                // Lowercase letter
                // If transitioning from digit to letter, add underscore
                if (i > 0 && name[i - 1].isDigit() && result.isNotEmpty() && result.last() != '_') {
                    result.append('_')
                }
                result.append(c.lowercaseChar())
            }

            i++
        }

        return result.toString()
    }

    fun toZigFileName(name: String): String {
        return toSnakeCase(name) + ".zig"
    }

    /** Convert a Smithy member name to a Zig field name (snake_case + keyword escaping). */
    fun toFieldName(name: String): String {
        return escapeKeyword(toSnakeCase(name))
    }

    /** Escape Zig keywords with @"..." syntax. */
    fun escapeKeyword(name: String): String {
        return if (name in ZIG_KEYWORDS) "@\"$name\"" else name
    }

    private val ZIG_KEYWORDS = setOf(
        "addrspace", "align", "allowzero", "and", "anyframe", "anytype",
        "asm", "async", "await", "break", "callconv", "catch", "comptime",
        "const", "continue", "defer", "else", "enum", "errdefer", "error",
        "export", "extern", "false", "fn", "for", "if", "inline",
        "noreturn", "nosuspend", "null", "opaque", "or", "orelse",
        "packed", "pub", "resume", "return", "struct", "suspend",
        "switch", "test", "threadlocal", "true", "try", "type",
        "undefined", "union", "unreachable", "var", "volatile", "while",
    )
}

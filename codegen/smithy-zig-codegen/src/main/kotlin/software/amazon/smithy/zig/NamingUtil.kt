package software.amazon.smithy.zig

object NamingUtil {
    fun toSnakeCase(name: String): String {
        if (name.isEmpty()) return name

        val result = StringBuilder()
        var i = 0

        while (i < name.length) {
            val c = name[i]

            if (i == 0) {
                result.append(c.lowercaseChar())
                i++
                continue
            }

            if (c == '_' || c == '-') {
                result.append('_')
                i++
                continue
            }

            if (c.isUpperCase()) {
                // Check if this is part of an acronym (consecutive uppercase)
                if (i + 1 < name.length && name[i + 1].isUpperCase()) {
                    // Find the end of the acronym
                    var end = i
                    while (end < name.length && name[end].isUpperCase()) {
                        end++
                    }
                    // If the acronym is followed by a lowercase letter, the last
                    // uppercase char is the start of the next word
                    if (end < name.length && name[end].isLowerCase()) {
                        end--
                    }
                    if (result.isNotEmpty() && result.last() != '_') {
                        result.append('_')
                    }
                    for (j in i until end) {
                        result.append(name[j].lowercaseChar())
                    }
                    i = end
                } else {
                    // Single uppercase letter -- start of a new word
                    if (result.isNotEmpty() && result.last() != '_') {
                        result.append('_')
                    }
                    result.append(c.lowercaseChar())
                    i++
                }
            } else if (c.isDigit() && i > 0 && !name[i - 1].isDigit()) {
                // Digit boundary
                if (result.isNotEmpty() && result.last() != '_') {
                    result.append('_')
                }
                result.append(c)
                i++
            } else if (!c.isDigit() && i > 0 && name[i - 1].isDigit()) {
                // After digits, start new word
                if (result.isNotEmpty() && result.last() != '_') {
                    result.append('_')
                }
                result.append(c.lowercaseChar())
                i++
            } else {
                result.append(c.lowercaseChar())
                i++
            }
        }

        return result.toString()
    }

    fun toZigFileName(name: String): String {
        return toSnakeCase(name) + ".zig"
    }
}

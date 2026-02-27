/// Information about a rewrite transform. This transform matches a pattern and
/// replaces it with the specified string.
pub const RewriteConfig = struct {
    /// The regular expression to match in the input string. The maximum length of
    /// the string is 1,024 characters.
    regex: []const u8,

    /// The replacement string to use when rewriting the matched input. The maximum
    /// length of the string is 1,024 characters.
    /// You can specify capture groups in the regular expression (for example, $1
    /// and $2).
    replace: []const u8,
};

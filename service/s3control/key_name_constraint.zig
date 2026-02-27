/// If provided, the generated manifest includes only source bucket objects
/// whose object
/// keys match the string constraints specified for `MatchAnyPrefix`,
/// `MatchAnySuffix`, and `MatchAnySubstring`.
pub const KeyNameConstraint = struct {
    /// If provided, the generated manifest includes objects where the specified
    /// string appears
    /// at the start of the object key string. Each KeyNameConstraint filter accepts
    /// an array of strings with a length of 1 string.
    match_any_prefix: ?[]const []const u8,

    /// If provided, the generated manifest includes objects where the specified
    /// string appears
    /// anywhere within the object key string. Each KeyNameConstraint filter accepts
    /// an array of strings with a length of 1 string.
    match_any_substring: ?[]const []const u8,

    /// If provided, the generated manifest includes objects where the specified
    /// string appears
    /// at the end of the object key string. Each KeyNameConstraint filter accepts
    /// an array of strings with a length of 1 string.
    match_any_suffix: ?[]const []const u8,
};

/// An object representing a custom pattern for detecting sensitive data across
/// the columns and rows of your structured data.
pub const CustomEntityType = struct {
    /// A list of context words. If none of these context words are found within the
    /// vicinity of the regular expression the data will not be detected as
    /// sensitive data.
    ///
    /// If no context words are passed only a regular expression is checked.
    context_words: ?[]const []const u8,

    /// A name for the custom pattern that allows it to be retrieved or deleted
    /// later. This name must be unique per Amazon Web Services account.
    name: []const u8,

    /// A regular expression string that is used for detecting sensitive data in a
    /// custom pattern.
    regex_string: []const u8,

    pub const json_field_names = .{
        .context_words = "ContextWords",
        .name = "Name",
        .regex_string = "RegexString",
    };
};

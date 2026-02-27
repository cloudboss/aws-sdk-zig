/// Information about a host header condition.
pub const HostHeaderConditionConfig = struct {
    /// The regular expressions to compare against the host header. The maximum
    /// length of each string is 128 characters.
    regex_values: ?[]const []const u8,

    /// The host names. The maximum length of each string is 128 characters. The
    /// comparison is
    /// case insensitive. The following wildcard characters are supported: *
    /// (matches 0 or more
    /// characters) and ? (matches exactly 1 character). You must include at least
    /// one "."
    /// character. You can include only alphabetical characters after the final "."
    /// character.
    ///
    /// If you specify multiple strings, the condition is satisfied if one of the
    /// strings matches
    /// the host name.
    values: ?[]const []const u8,
};

const MatchOption = @import("match_option.zig").MatchOption;

/// The values that are available for a tag.
///
/// If `Values` and `Key` aren't specified, the `ABSENT`
/// `MatchOption` is applied to all tags. That is, it's filtered on resources
/// with no tags.
///
/// If `Key` is provided and `Values` isn't specified, the
/// `ABSENT`
/// `MatchOption` is applied to the tag `Key` only. That is, it's
/// filtered on resources without the given tag key.
pub const TagValues = struct {
    /// The key for the tag.
    key: ?[]const u8 = null,

    /// The match options that you can use to filter your results. `MatchOptions`
    /// is only applicable for actions related to cost category. The default values
    /// for
    /// `MatchOptions` are `EQUALS` and
    /// `CASE_SENSITIVE`.
    match_options: ?[]const MatchOption = null,

    /// The specific value of the tag.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .match_options = "MatchOptions",
        .values = "Values",
    };
};

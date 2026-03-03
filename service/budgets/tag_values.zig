const MatchOption = @import("match_option.zig").MatchOption;

/// The values that are available for a tag.
pub const TagValues = struct {
    /// The key for the tag.
    key: ?[]const u8 = null,

    /// The match options that you can use to filter your results.
    match_options: ?[]const MatchOption = null,

    /// The specific value of the tag.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .match_options = "MatchOptions",
        .values = "Values",
    };
};

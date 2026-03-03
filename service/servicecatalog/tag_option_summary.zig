/// Summary information about a TagOption.
pub const TagOptionSummary = struct {
    /// The TagOption key.
    key: ?[]const u8 = null,

    /// The TagOption value.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};

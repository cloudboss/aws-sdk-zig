/// The key-value pair used for the row-level security tags feature.
pub const SessionTag = struct {
    /// The key for the tag.
    key: []const u8,

    /// The value that you want to assign the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};

/// A key-value pair to filter results.
pub const Filter = struct {
    /// The key for the filter.
    key: []const u8,

    /// The values for the filter keys.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};

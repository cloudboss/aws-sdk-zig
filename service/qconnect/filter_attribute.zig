/// An attribute used for filtering.
pub const FilterAttribute = struct {
    /// The key of the filter attribute.
    key: []const u8,

    /// The value of the filter attribute.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};

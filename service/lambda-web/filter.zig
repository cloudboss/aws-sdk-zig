/// A filter to apply when listing resources.
pub const Filter = struct {
    /// The name of the filter field.
    name: []const u8,

    /// The values to match for the filter.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};

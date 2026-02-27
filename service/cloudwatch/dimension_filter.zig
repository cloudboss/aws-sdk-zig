/// Represents filters for a dimension.
pub const DimensionFilter = struct {
    /// The dimension name to be matched.
    name: []const u8,

    /// The value of the dimension to be matched.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};

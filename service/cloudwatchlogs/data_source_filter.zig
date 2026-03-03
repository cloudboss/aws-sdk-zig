/// Filter criteria for data sources, used to specify which data sources to
/// include in
/// operations based on name and type.
pub const DataSourceFilter = struct {
    /// The name pattern to filter data sources by.
    name: []const u8,

    /// The type pattern to filter data sources by.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};

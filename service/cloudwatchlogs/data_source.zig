/// Represents a data source that categorizes logs by originating service and
/// log type,
/// providing service-based organization complementing traditional log groups.
pub const DataSource = struct {
    /// The name of the data source.
    name: []const u8,

    /// The type of the data source.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};

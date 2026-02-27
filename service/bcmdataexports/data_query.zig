const aws = @import("aws");

/// The SQL query of column selections and row filters from the data table you
/// want.
pub const DataQuery = struct {
    /// The query statement.
    query_statement: []const u8,

    /// The table configuration.
    table_configurations: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry),

    pub const json_field_names = .{
        .query_statement = "QueryStatement",
        .table_configurations = "TableConfigurations",
    };
};

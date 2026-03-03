const FilterExpression = @import("filter_expression.zig").FilterExpression;

/// The relational filter configuration for the data source.
pub const RelationalFilterConfiguration = struct {
    /// The database name specified in the relational filter configuration for the
    /// data source.
    database_name: []const u8,

    /// The filter expressions specified in the relational filter configuration for
    /// the data source.
    filter_expressions: ?[]const FilterExpression = null,

    /// The schema name specified in the relational filter configuration for the
    /// data source.
    schema_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .database_name = "databaseName",
        .filter_expressions = "filterExpressions",
        .schema_name = "schemaName",
    };
};

const ColumnDefinition = @import("column_definition.zig").ColumnDefinition;

/// Definition for a schema on a tabular Dataset.
pub const SchemaDefinition = struct {
    /// List of column definitions.
    columns: ?[]const ColumnDefinition,

    /// List of column names used for primary key.
    primary_key_columns: ?[]const []const u8,

    pub const json_field_names = .{
        .columns = "columns",
        .primary_key_columns = "primaryKeyColumns",
    };
};

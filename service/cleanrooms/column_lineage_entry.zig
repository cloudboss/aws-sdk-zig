const BaseTableDependencyType = @import("base_table_dependency_type.zig").BaseTableDependencyType;

/// Contains column lineage information that traces a disallowed output column
/// back to its source in a base table.
pub const ColumnLineageEntry = struct {
    /// The name of the column in the intermediate table.
    column: []const u8,

    /// The Amazon Web Services account ID of the owner of the source table.
    source_account_id: []const u8,

    /// The name of the column in the source table.
    source_column: []const u8,

    /// The unique identifier of the source table.
    source_id: []const u8,

    /// The name of the source table.
    source_name: []const u8,

    /// The type of the source table.
    source_type: BaseTableDependencyType,

    pub const json_field_names = .{
        .column = "column",
        .source_account_id = "sourceAccountId",
        .source_column = "sourceColumn",
        .source_id = "sourceId",
        .source_name = "sourceName",
        .source_type = "sourceType",
    };
};

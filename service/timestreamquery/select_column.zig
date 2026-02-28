const Type = @import("type.zig").Type;

/// Details of the column that is returned by the query.
pub const SelectColumn = struct {
    /// True, if the column name was aliased by the query. False otherwise.
    aliased: ?bool,

    /// Database that has this column.
    database_name: ?[]const u8,

    /// Name of the column.
    name: ?[]const u8,

    /// Table within the database that has this column.
    table_name: ?[]const u8,

    @"type": ?Type,

    pub const json_field_names = .{
        .aliased = "Aliased",
        .database_name = "DatabaseName",
        .name = "Name",
        .table_name = "TableName",
        .@"type" = "Type",
    };
};

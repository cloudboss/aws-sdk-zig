const Type = @import("type.zig").Type;

/// Details of the column that is returned by the query.
pub const SelectColumn = struct {
    /// True, if the column name was aliased by the query. False otherwise.
    aliased: ?bool = null,

    /// Database that has this column.
    database_name: ?[]const u8 = null,

    /// Name of the column.
    name: ?[]const u8 = null,

    /// Table within the database that has this column.
    table_name: ?[]const u8 = null,

    @"type": ?Type = null,

    pub const json_field_names = .{
        .aliased = "Aliased",
        .database_name = "DatabaseName",
        .name = "Name",
        .table_name = "TableName",
        .@"type" = "Type",
    };
};

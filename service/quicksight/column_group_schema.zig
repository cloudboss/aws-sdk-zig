const ColumnGroupColumnSchema = @import("column_group_column_schema.zig").ColumnGroupColumnSchema;

/// The column group schema.
pub const ColumnGroupSchema = struct {
    /// A structure containing the list of schemas for column group columns.
    column_group_column_schema_list: ?[]const ColumnGroupColumnSchema = null,

    /// The name of the column group schema.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .column_group_column_schema_list = "ColumnGroupColumnSchemaList",
        .name = "Name",
    };
};

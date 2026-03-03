const ColumnSchema = @import("column_schema.zig").ColumnSchema;

/// Dataset schema.
pub const DataSetSchema = struct {
    /// A structure containing the list of column schemas.
    column_schema_list: ?[]const ColumnSchema = null,

    pub const json_field_names = .{
        .column_schema_list = "ColumnSchemaList",
    };
};

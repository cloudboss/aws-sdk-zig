const ColumnGroupSchema = @import("column_group_schema.zig").ColumnGroupSchema;
const DataSetSchema = @import("data_set_schema.zig").DataSetSchema;

/// Dataset configuration.
pub const DataSetConfiguration = struct {
    /// A structure containing the list of column group schemas.
    column_group_schema_list: ?[]const ColumnGroupSchema = null,

    /// Dataset schema.
    data_set_schema: ?DataSetSchema = null,

    /// Placeholder.
    placeholder: ?[]const u8 = null,

    pub const json_field_names = .{
        .column_group_schema_list = "ColumnGroupSchemaList",
        .data_set_schema = "DataSetSchema",
        .placeholder = "Placeholder",
    };
};

const ColumnGroupSchema = @import("column_group_schema.zig").ColumnGroupSchema;
const DataSetSchema = @import("data_set_schema.zig").DataSetSchema;

/// The configuration of a topic.
pub const TopicConfiguration = struct {
    /// The list of column group schemas in the topic configuration.
    column_group_schema_list: ?[]const ColumnGroupSchema = null,

    /// Topic schema.
    data_set_schema: ?DataSetSchema = null,

    /// The placeholder for the topic configuration.
    placeholder: ?[]const u8 = null,

    pub const json_field_names = .{
        .column_group_schema_list = "ColumnGroupSchemaList",
        .data_set_schema = "DataSetSchema",
        .placeholder = "Placeholder",
    };
};

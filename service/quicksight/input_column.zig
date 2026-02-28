const ColumnDataSubType = @import("column_data_sub_type.zig").ColumnDataSubType;
const InputColumnDataType = @import("input_column_data_type.zig").InputColumnDataType;

/// Metadata for a column that is used as the input of a transform operation.
pub const InputColumn = struct {
    /// A unique identifier for the input column.
    id: ?[]const u8,

    /// The name of this column in the underlying data source.
    name: []const u8,

    /// The sub data type of the column. Sub types are only available for decimal
    /// columns that are part of a SPICE dataset.
    sub_type: ?ColumnDataSubType,

    /// The data type of the column.
    @"type": InputColumnDataType,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .sub_type = "SubType",
        .@"type" = "Type",
    };
};

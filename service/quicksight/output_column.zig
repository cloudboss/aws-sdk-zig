const ColumnDataSubType = @import("column_data_sub_type.zig").ColumnDataSubType;
const ColumnDataType = @import("column_data_type.zig").ColumnDataType;

/// Output column.
pub const OutputColumn = struct {
    /// A description for a column.
    description: ?[]const u8,

    /// A unique identifier for the output column.
    id: ?[]const u8,

    /// The display name of the column..
    name: ?[]const u8,

    /// The sub data type of the column.
    sub_type: ?ColumnDataSubType,

    /// The data type of the column.
    type: ?ColumnDataType,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .sub_type = "SubType",
        .type = "Type",
    };
};

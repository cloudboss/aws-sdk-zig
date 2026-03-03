const ColumnDataType = @import("column_data_type.zig").ColumnDataType;
const ColumnDataSubType = @import("column_data_sub_type.zig").ColumnDataSubType;

/// A transform operation that casts a column to a different type.
pub const CastColumnTypeOperation = struct {
    /// Column name.
    column_name: []const u8,

    /// When casting a column from string to datetime type, you can supply a string
    /// in a
    /// format supported by Quick Sight to denote the source data format.
    format: ?[]const u8 = null,

    /// New column data type.
    new_column_type: ColumnDataType,

    /// The sub data type of the new column. Sub types are only available for
    /// decimal columns that are part of a SPICE dataset.
    sub_type: ?ColumnDataSubType = null,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .format = "Format",
        .new_column_type = "NewColumnType",
        .sub_type = "SubType",
    };
};

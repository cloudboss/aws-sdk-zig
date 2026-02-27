/// Specifies a column to be unpivoted, transforming it from a column into rows
/// with associated values.
pub const ColumnToUnpivot = struct {
    /// The name of the column to unpivot from the source data.
    column_name: ?[]const u8,

    /// The value to assign to this column in the unpivoted result, typically the
    /// column name or a descriptive label.
    new_value: ?[]const u8,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .new_value = "NewValue",
    };
};

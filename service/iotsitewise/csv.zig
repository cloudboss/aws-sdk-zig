const ColumnName = @import("column_name.zig").ColumnName;

/// A .CSV file.
pub const Csv = struct {
    /// The column names specified in the .csv file.
    column_names: []const ColumnName,

    pub const json_field_names = .{
        .column_names = "columnNames",
    };
};

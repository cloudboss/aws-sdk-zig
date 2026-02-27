/// A structure containing the column name and column importance score for a
/// column.
///
/// Column importance helps you understand how columns contribute to your model,
/// by identifying which columns in your records are more important than others.
pub const ColumnImportance = struct {
    /// The name of a column.
    column_name: ?[]const u8,

    /// The column importance score for the column, as a decimal.
    importance: ?f64,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .importance = "Importance",
    };
};

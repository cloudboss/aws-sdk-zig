/// Specifies a label value to be pivoted into a separate column, including the
/// new column name and identifier.
pub const PivotedLabel = struct {
    /// The label value from the source data to be pivoted.
    label_name: []const u8,

    /// A unique identifier for the new column created from this pivoted label.
    new_column_id: []const u8,

    /// The name for the new column created from this pivoted label.
    new_column_name: []const u8,

    pub const json_field_names = .{
        .label_name = "LabelName",
        .new_column_id = "NewColumnId",
        .new_column_name = "NewColumnName",
    };
};

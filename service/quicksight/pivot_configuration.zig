const PivotedLabel = @import("pivoted_label.zig").PivotedLabel;

/// Configuration for a pivot operation, specifying which column contains labels
/// and how to pivot them.
pub const PivotConfiguration = struct {
    /// The name of the column that contains the labels to be pivoted into separate
    /// columns.
    label_column_name: ?[]const u8 = null,

    /// The list of specific label values to pivot into separate columns.
    pivoted_labels: []const PivotedLabel,

    pub const json_field_names = .{
        .label_column_name = "LabelColumnName",
        .pivoted_labels = "PivotedLabels",
    };
};

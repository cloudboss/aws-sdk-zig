const DatasetLabelStats = @import("dataset_label_stats.zig").DatasetLabelStats;

/// Describes a dataset label. For more information, see ListDatasetLabels.
pub const DatasetLabelDescription = struct {
    /// The name of the label.
    label_name: ?[]const u8 = null,

    /// Statistics about the label.
    label_stats: ?DatasetLabelStats = null,

    pub const json_field_names = .{
        .label_name = "LabelName",
        .label_stats = "LabelStats",
    };
};

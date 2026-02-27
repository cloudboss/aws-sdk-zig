/// Provides statistics about a dataset. For more information, see
/// DescribeDataset.
pub const DatasetStats = struct {
    /// The total number of entries that contain at least one error.
    error_entries: ?i32,

    /// The total number of images in the dataset that have labels.
    labeled_entries: ?i32,

    /// The total number of images in the dataset.
    total_entries: ?i32,

    /// The total number of labels declared in the dataset.
    total_labels: ?i32,

    pub const json_field_names = .{
        .error_entries = "ErrorEntries",
        .labeled_entries = "LabeledEntries",
        .total_entries = "TotalEntries",
        .total_labels = "TotalLabels",
    };
};

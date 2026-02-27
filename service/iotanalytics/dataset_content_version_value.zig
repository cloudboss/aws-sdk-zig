/// The dataset whose latest contents are used as input to the notebook or
/// application.
pub const DatasetContentVersionValue = struct {
    /// The name of the dataset whose latest contents are used as input to the
    /// notebook or
    /// application.
    dataset_name: []const u8,

    pub const json_field_names = .{
        .dataset_name = "datasetName",
    };
};

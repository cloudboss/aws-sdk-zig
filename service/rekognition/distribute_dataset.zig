/// A training dataset or a test dataset used in a dataset distribution
/// operation.
/// For more information, see DistributeDatasetEntries.
pub const DistributeDataset = struct {
    /// The Amazon Resource Name (ARN) of the dataset that you want to use.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

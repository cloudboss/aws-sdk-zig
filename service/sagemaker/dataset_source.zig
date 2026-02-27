/// Specifies a dataset source for a channel.
pub const DatasetSource = struct {
    /// The Amazon Resource Name (ARN) of the dataset resource.
    dataset_arn: []const u8,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
    };
};

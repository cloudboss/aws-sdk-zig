const Source = @import("source.zig").Source;

/// Contains information about the dataset use and it's source.
pub const DataSetReference = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// of the dataset.
    /// The format is
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:dataset/${DatasetId}`.
    dataset_arn: ?[]const u8 = null,

    /// The data source for the dataset.
    source: ?Source = null,

    pub const json_field_names = .{
        .dataset_arn = "datasetArn",
        .source = "source",
    };
};

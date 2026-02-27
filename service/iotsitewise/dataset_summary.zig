const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

/// The summary details for the dataset.
pub const DatasetSummary = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// of the dataset.
    /// The format is
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:dataset/${DatasetId}`.
    arn: []const u8,

    /// The dataset creation date, in Unix epoch time.
    creation_date: i64,

    /// A description about the dataset, and its functionality.
    description: []const u8,

    /// The ID of the dataset.
    id: []const u8,

    /// The date the dataset was last updated, in Unix epoch time.
    last_update_date: i64,

    /// The name of the dataset.
    name: []const u8,

    /// The status of the dataset. This contains the state and any error messages.
    /// The state is
    /// `ACTIVE` when ready to use.
    status: DatasetStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_date = "creationDate",
        .description = "description",
        .id = "id",
        .last_update_date = "lastUpdateDate",
        .name = "name",
        .status = "status",
    };
};

/// Provides a summary of the properties of a dataset. For a complete listing,
/// call the
/// [DescribeDataset](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDataset.html) API.
pub const DatasetSummary = struct {
    /// The date and time (in Unix time) that the dataset was created.
    creation_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: ?[]const u8,

    /// The dataset type. One of the following values:
    ///
    /// * Interactions
    ///
    /// * Items
    ///
    /// * Users
    ///
    /// * Event-Interactions
    dataset_type: ?[]const u8,

    /// The date and time (in Unix time) that the dataset was last updated.
    last_updated_date_time: ?i64,

    /// The name of the dataset.
    name: ?[]const u8,

    /// The status of the dataset.
    ///
    /// A dataset can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_arn = "datasetArn",
        .dataset_type = "datasetType",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .status = "status",
    };
};

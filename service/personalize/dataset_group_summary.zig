const Domain = @import("domain.zig").Domain;

/// Provides a summary of the properties of a dataset group. For a complete
/// listing, call the
/// [DescribeDatasetGroup](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDatasetGroup.html) API.
pub const DatasetGroupSummary = struct {
    /// The date and time (in Unix time) that the dataset group was created.
    creation_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the dataset group.
    dataset_group_arn: ?[]const u8,

    /// The domain of a Domain dataset group.
    domain: ?Domain,

    /// If creating a dataset group fails, the reason behind the failure.
    failure_reason: ?[]const u8,

    /// The date and time (in Unix time) that the dataset group was last updated.
    last_updated_date_time: ?i64,

    /// The name of the dataset group.
    name: ?[]const u8,

    /// The status of the dataset group.
    ///
    /// A dataset group can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_group_arn = "datasetGroupArn",
        .domain = "domain",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .status = "status",
    };
};

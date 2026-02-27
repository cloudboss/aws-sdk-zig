/// Provides a summary of the dataset group properties used in the
/// [ListDatasetGroups](https://docs.aws.amazon.com/forecast/latest/dg/API_ListDatasetGroups.html) operation. To
/// get the complete set of properties, call the
/// [DescribeDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDatasetGroup.html)
/// operation, and provide the `DatasetGroupArn`.
pub const DatasetGroupSummary = struct {
    /// When the dataset group was created.
    creation_time: ?i64,

    /// The Amazon Resource Name (ARN) of the dataset group.
    dataset_group_arn: ?[]const u8,

    /// The name of the dataset group.
    dataset_group_name: ?[]const u8,

    /// When the dataset group was created or last updated from a call to the
    /// [UpdateDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_UpdateDatasetGroup.html) operation. While the dataset group is being updated,
    /// `LastModificationTime` is the current time of the `ListDatasetGroups`
    /// call.
    last_modification_time: ?i64,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .dataset_group_arn = "DatasetGroupArn",
        .dataset_group_name = "DatasetGroupName",
        .last_modification_time = "LastModificationTime",
    };
};

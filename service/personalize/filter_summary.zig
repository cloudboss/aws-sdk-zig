/// A short summary of a filter's attributes.
pub const FilterSummary = struct {
    /// The time at which the filter was created.
    creation_date_time: ?i64 = null,

    /// The ARN of the dataset group to which the filter belongs.
    dataset_group_arn: ?[]const u8 = null,

    /// If the filter failed, the reason for the failure.
    failure_reason: ?[]const u8 = null,

    /// The ARN of the filter.
    filter_arn: ?[]const u8 = null,

    /// The time at which the filter was last updated.
    last_updated_date_time: ?i64 = null,

    /// The name of the filter.
    name: ?[]const u8 = null,

    /// The status of the filter.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_group_arn = "datasetGroupArn",
        .failure_reason = "failureReason",
        .filter_arn = "filterArn",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .status = "status",
    };
};

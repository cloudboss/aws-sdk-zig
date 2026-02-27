/// Contains information on a recommendation filter, including its ARN, status,
/// and filter
/// expression.
pub const Filter = struct {
    /// The time at which the filter was created.
    creation_date_time: ?i64,

    /// The ARN of the dataset group to which the filter belongs.
    dataset_group_arn: ?[]const u8,

    /// If the filter failed, the reason for its failure.
    failure_reason: ?[]const u8,

    /// The ARN of the filter.
    filter_arn: ?[]const u8,

    /// Specifies the type of item interactions to filter out of recommendation
    /// results. The
    /// filter expression must follow specific format rules. For information about
    /// filter expression structure and syntax, see
    /// [Filter
    /// expressions](https://docs.aws.amazon.com/personalize/latest/dg/filter-expressions.html).
    filter_expression: ?[]const u8,

    /// The time at which the filter was last updated.
    last_updated_date_time: ?i64,

    /// The name of the filter.
    name: ?[]const u8,

    /// The status of the filter.
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_group_arn = "datasetGroupArn",
        .failure_reason = "failureReason",
        .filter_arn = "filterArn",
        .filter_expression = "filterExpression",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .status = "status",
    };
};

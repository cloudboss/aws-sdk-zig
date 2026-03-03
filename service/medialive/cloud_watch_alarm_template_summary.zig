const aws = @import("aws");

const CloudWatchAlarmTemplateComparisonOperator = @import("cloud_watch_alarm_template_comparison_operator.zig").CloudWatchAlarmTemplateComparisonOperator;
const CloudWatchAlarmTemplateStatistic = @import("cloud_watch_alarm_template_statistic.zig").CloudWatchAlarmTemplateStatistic;
const CloudWatchAlarmTemplateTargetResourceType = @import("cloud_watch_alarm_template_target_resource_type.zig").CloudWatchAlarmTemplateTargetResourceType;
const CloudWatchAlarmTemplateTreatMissingData = @import("cloud_watch_alarm_template_treat_missing_data.zig").CloudWatchAlarmTemplateTreatMissingData;

/// Placeholder documentation for CloudWatchAlarmTemplateSummary
pub const CloudWatchAlarmTemplateSummary = struct {
    /// A cloudwatch alarm template's ARN (Amazon Resource Name)
    arn: []const u8,

    comparison_operator: CloudWatchAlarmTemplateComparisonOperator,

    created_at: i64,

    /// The number of datapoints within the evaluation period that must be breaching
    /// to trigger the alarm.
    datapoints_to_alarm: ?i32 = null,

    /// A resource's optional description.
    description: ?[]const u8 = null,

    /// The number of periods over which data is compared to the specified
    /// threshold.
    evaluation_periods: i32,

    /// A cloudwatch alarm template group's id. AWS provided template groups have
    /// ids that start with `aws-`
    group_id: []const u8,

    /// A cloudwatch alarm template's id. AWS provided templates have ids that start
    /// with `aws-`
    id: []const u8,

    /// The name of the metric associated with the alarm. Must be compatible with
    /// targetResourceType.
    metric_name: []const u8,

    modified_at: ?i64 = null,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: []const u8,

    /// The period, in seconds, over which the specified statistic is applied.
    period: i32,

    statistic: CloudWatchAlarmTemplateStatistic,

    tags: ?[]const aws.map.StringMapEntry = null,

    target_resource_type: CloudWatchAlarmTemplateTargetResourceType,

    /// The threshold value to compare with the specified statistic.
    threshold: f64,

    treat_missing_data: CloudWatchAlarmTemplateTreatMissingData,

    pub const json_field_names = .{
        .arn = "Arn",
        .comparison_operator = "ComparisonOperator",
        .created_at = "CreatedAt",
        .datapoints_to_alarm = "DatapointsToAlarm",
        .description = "Description",
        .evaluation_periods = "EvaluationPeriods",
        .group_id = "GroupId",
        .id = "Id",
        .metric_name = "MetricName",
        .modified_at = "ModifiedAt",
        .name = "Name",
        .period = "Period",
        .statistic = "Statistic",
        .tags = "Tags",
        .target_resource_type = "TargetResourceType",
        .threshold = "Threshold",
        .treat_missing_data = "TreatMissingData",
    };
};

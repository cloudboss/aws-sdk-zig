const ScheduleConfiguration = @import("schedule_configuration.zig").ScheduleConfiguration;
const Tag = @import("tag.zig").Tag;

/// The configuration of the CloudWatch Logs scheduled query that backs a log
/// alarm.
pub const ScheduledQueryConfiguration = struct {
    /// The expression that defines how to aggregate query results into one or more
    /// scalar values for alarm evaluation. For example, `count(*)` or `avg(latency)
    /// by host | sort desc`. Length constraints: minimum 1 character, maximum 2048
    /// characters.
    aggregation_expression: []const u8,

    /// The log groups to query. Each entry can be a log group name or ARN. Use the
    /// ARN form when querying log groups in a different account (for example, when
    /// running cross-account queries from a monitoring account). The list must
    /// contain between 1 and 50 entries.
    log_group_identifiers: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the CloudWatch Logs scheduled query that
    /// the alarm uses. This field is populated in `DescribeAlarms` responses.
    query_arn: ?[]const u8 = null,

    /// The CloudWatch Logs query to execute on each scheduled run. Length
    /// constraints: maximum of 10,000 characters.
    query_string: []const u8,

    /// The schedule and time-range offset configuration for the underlying
    /// scheduled query.
    schedule_configuration: ScheduleConfiguration,

    /// The Amazon Resource Name (ARN) of the IAM role that CloudWatch assumes when
    /// executing the scheduled query against the configured log groups.
    scheduled_query_role_arn: []const u8,

    /// A list of key-value pairs to associate with the underlying scheduled query
    /// resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aggregation_expression = "AggregationExpression",
        .log_group_identifiers = "LogGroupIdentifiers",
        .query_arn = "QueryARN",
        .query_string = "QueryString",
        .schedule_configuration = "ScheduleConfiguration",
        .scheduled_query_role_arn = "ScheduledQueryRoleARN",
        .tags = "Tags",
    };
};

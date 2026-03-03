const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const ScheduledQueryState = @import("scheduled_query_state.zig").ScheduledQueryState;

/// Summary information about a scheduled query, including basic configuration
/// and execution
/// status.
pub const ScheduledQuerySummary = struct {
    /// The timestamp when the scheduled query was created.
    creation_time: ?i64 = null,

    /// Configuration for where query results are delivered.
    destination_configuration: ?DestinationConfiguration = null,

    /// The status of the most recent execution.
    last_execution_status: ?ExecutionStatus = null,

    /// The timestamp when the scheduled query was last executed.
    last_triggered_time: ?i64 = null,

    /// The timestamp when the scheduled query was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the scheduled query.
    name: ?[]const u8 = null,

    /// The ARN of the scheduled query.
    scheduled_query_arn: ?[]const u8 = null,

    /// The cron expression that defines when the scheduled query runs.
    schedule_expression: ?[]const u8 = null,

    /// The current state of the scheduled query.
    state: ?ScheduledQueryState = null,

    /// The timezone used for evaluating the schedule expression.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .destination_configuration = "destinationConfiguration",
        .last_execution_status = "lastExecutionStatus",
        .last_triggered_time = "lastTriggeredTime",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .scheduled_query_arn = "scheduledQueryArn",
        .schedule_expression = "scheduleExpression",
        .state = "state",
        .timezone = "timezone",
    };
};

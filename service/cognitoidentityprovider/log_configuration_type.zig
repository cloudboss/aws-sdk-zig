const CloudWatchLogsConfigurationType = @import("cloud_watch_logs_configuration_type.zig").CloudWatchLogsConfigurationType;
const EventSourceName = @import("event_source_name.zig").EventSourceName;
const FirehoseConfigurationType = @import("firehose_configuration_type.zig").FirehoseConfigurationType;
const LogLevel = @import("log_level.zig").LogLevel;
const S3ConfigurationType = @import("s3_configuration_type.zig").S3ConfigurationType;

/// The configuration of user event logs to an external Amazon Web Services
/// service like
/// Amazon Data Firehose, Amazon S3, or Amazon CloudWatch Logs.
pub const LogConfigurationType = struct {
    /// The CloudWatch log group destination of user pool detailed activity logs, or
    /// of user
    /// activity log export with threat protection.
    cloud_watch_logs_configuration: ?CloudWatchLogsConfigurationType,

    /// The source of events that your user pool sends for logging. To send
    /// error-level logs
    /// about user notification activity, set to `userNotification`. To send
    /// info-level logs about threat-protection user activity in user pools with the
    /// Plus
    /// feature plan, set to `userAuthEvents`.
    event_source: EventSourceName,

    /// The Amazon Data Firehose stream destination of user activity log export with
    /// threat protection.
    /// To activate this setting, your user pool must be on the [
    /// Plus
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-plus.html).
    firehose_configuration: ?FirehoseConfigurationType,

    /// The `errorlevel` selection of logs that a user pool sends for detailed
    /// activity logging. To send `userNotification` activity with [information
    /// about message
    /// delivery](https://docs.aws.amazon.com/cognito/latest/developerguide/exporting-quotas-and-usage.html), choose `ERROR` with
    /// `CloudWatchLogsConfiguration`. To send `userAuthEvents`
    /// activity with user logs from threat protection with the Plus feature plan,
    /// choose
    /// `INFO` with one of `CloudWatchLogsConfiguration`,
    /// `FirehoseConfiguration`, or `S3Configuration`.
    log_level: LogLevel,

    /// The Amazon S3 bucket destination of user activity log export with threat
    /// protection.
    /// To activate this setting, your user pool must be on the [
    /// Plus
    /// tier](https://docs.aws.amazon.com/cognito/latest/developerguide/feature-plans-features-plus.html).
    s3_configuration: ?S3ConfigurationType,

    pub const json_field_names = .{
        .cloud_watch_logs_configuration = "CloudWatchLogsConfiguration",
        .event_source = "EventSource",
        .firehose_configuration = "FirehoseConfiguration",
        .log_level = "LogLevel",
        .s3_configuration = "S3Configuration",
    };
};

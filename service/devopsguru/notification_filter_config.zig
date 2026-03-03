const NotificationMessageType = @import("notification_message_type.zig").NotificationMessageType;
const InsightSeverity = @import("insight_severity.zig").InsightSeverity;

/// The filter configurations for the Amazon SNS notification topic you use with
/// DevOps Guru. You can choose to specify which events or message types to
/// receive notifications for.
/// You can also choose to specify which severity levels to receive
/// notifications for.
pub const NotificationFilterConfig = struct {
    /// The events that you want to receive notifications for. For example, you can
    /// choose to receive notifications only when the severity level is upgraded or
    /// a new insight is created.
    message_types: ?[]const NotificationMessageType = null,

    /// The severity levels that you want to receive notifications for. For example,
    /// you can choose to receive notifications only for insights with `HIGH` and
    /// `MEDIUM` severity levels.
    /// For more information, see [Understanding insight
    /// severities](https://docs.aws.amazon.com/devops-guru/latest/userguide/working-with-insights.html#understanding-insights-severities).
    severities: ?[]const InsightSeverity = null,

    pub const json_field_names = .{
        .message_types = "MessageTypes",
        .severities = "Severities",
    };
};

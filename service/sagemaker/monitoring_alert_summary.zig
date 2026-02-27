const MonitoringAlertActions = @import("monitoring_alert_actions.zig").MonitoringAlertActions;
const MonitoringAlertStatus = @import("monitoring_alert_status.zig").MonitoringAlertStatus;

/// Provides summary information about a monitor alert.
pub const MonitoringAlertSummary = struct {
    /// A list of alert actions taken in response to an alert going into `InAlert`
    /// status.
    actions: MonitoringAlertActions,

    /// The current status of an alert.
    alert_status: MonitoringAlertStatus,

    /// A timestamp that indicates when a monitor alert was created.
    creation_time: i64,

    /// Within `EvaluationPeriod`, how many execution failures will raise an alert.
    datapoints_to_alert: i32,

    /// The number of most recent monitoring executions to consider when evaluating
    /// alert status.
    evaluation_period: i32,

    /// A timestamp that indicates when a monitor alert was last updated.
    last_modified_time: i64,

    /// The name of a monitoring alert.
    monitoring_alert_name: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .alert_status = "AlertStatus",
        .creation_time = "CreationTime",
        .datapoints_to_alert = "DatapointsToAlert",
        .evaluation_period = "EvaluationPeriod",
        .last_modified_time = "LastModifiedTime",
        .monitoring_alert_name = "MonitoringAlertName",
    };
};

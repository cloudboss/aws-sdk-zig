const MonitoringAlertStatus = @import("monitoring_alert_status.zig").MonitoringAlertStatus;

/// Provides summary information of an alert's history.
pub const MonitoringAlertHistorySummary = struct {
    /// The current alert status of an alert.
    alert_status: MonitoringAlertStatus,

    /// A timestamp that indicates when the first alert transition occurred in an
    /// alert history. An alert transition can be from status `InAlert` to `OK`, or
    /// from `OK` to `InAlert`.
    creation_time: i64,

    /// The name of a monitoring alert.
    monitoring_alert_name: []const u8,

    /// The name of a monitoring schedule.
    monitoring_schedule_name: []const u8,

    pub const json_field_names = .{
        .alert_status = "AlertStatus",
        .creation_time = "CreationTime",
        .monitoring_alert_name = "MonitoringAlertName",
        .monitoring_schedule_name = "MonitoringScheduleName",
    };
};

const MonitorStatus = @import("monitor_status.zig").MonitorStatus;

/// A summary of information about a monitor, including the ARN, the name, and
/// the status.
pub const MonitorSummary = struct {
    /// The Amazon Resource Name (ARN) of the monitor.
    monitor_arn: []const u8,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The status of a monitor. The status can be one of the following
    ///
    /// * `PENDING`: The monitor is in the process of being created.
    /// * `ACTIVE`: The monitor is active.
    /// * `INACTIVE`: The monitor is inactive.
    /// * `ERROR`: Monitor creation failed due to an error.
    /// * `DELETING`: The monitor is in the process of being deleted.
    monitor_status: MonitorStatus,

    pub const json_field_names = .{
        .monitor_arn = "monitorArn",
        .monitor_name = "monitorName",
        .monitor_status = "monitorStatus",
    };
};

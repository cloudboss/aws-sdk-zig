const MonitorProcessingStatusCode = @import("monitor_processing_status_code.zig").MonitorProcessingStatusCode;
const MonitorConfigState = @import("monitor_config_state.zig").MonitorConfigState;

/// The description of and information about a monitor in Amazon CloudWatch
/// Internet Monitor.
pub const Monitor = struct {
    /// The Amazon Resource Name (ARN) of the monitor.
    monitor_arn: []const u8,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The health of data processing for the monitor.
    processing_status: ?MonitorProcessingStatusCode = null,

    /// The status of a monitor.
    status: MonitorConfigState,

    pub const json_field_names = .{
        .monitor_arn = "MonitorArn",
        .monitor_name = "MonitorName",
        .processing_status = "ProcessingStatus",
        .status = "Status",
    };
};

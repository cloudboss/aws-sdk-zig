const DesiredState = @import("desired_state.zig").DesiredState;
const DeviceReportedStatus = @import("device_reported_status.zig").DeviceReportedStatus;

/// An application instance's state.
pub const ReportedRuntimeContextState = struct {
    /// The application's desired state.
    desired_state: DesiredState,

    /// The application's reported status.
    device_reported_status: DeviceReportedStatus,

    /// When the device reported the application's state.
    device_reported_time: i64,

    /// The device's name.
    runtime_context_name: []const u8,

    pub const json_field_names = .{
        .desired_state = "DesiredState",
        .device_reported_status = "DeviceReportedStatus",
        .device_reported_time = "DeviceReportedTime",
        .runtime_context_name = "RuntimeContextName",
    };
};

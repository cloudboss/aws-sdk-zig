const MonitoringState = @import("monitoring_state.zig").MonitoringState;

/// Describes the monitoring of an instance.
pub const Monitoring = struct {
    /// Indicates whether detailed monitoring is enabled. Otherwise, basic
    /// monitoring is
    /// enabled.
    state: ?MonitoringState = null,
};

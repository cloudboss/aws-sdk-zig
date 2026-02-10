const Monitoring = @import("monitoring.zig").Monitoring;

/// Describes the monitoring of an instance.
pub const InstanceMonitoring = struct {
    /// The ID of the instance.
    instance_id: ?[]const u8,

    /// The monitoring for the instance.
    monitoring: ?Monitoring,
};

const InstanceHealthStatus = @import("instance_health_status.zig").InstanceHealthStatus;

/// Describes a running instance in a Spot Fleet.
pub const ActiveInstance = struct {
    /// The health status of the instance. If the status of either the instance
    /// status check
    /// or the system status check is `impaired`, the health status of the instance
    /// is `unhealthy`. Otherwise, the health status is `healthy`.
    instance_health: ?InstanceHealthStatus = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The instance type.
    instance_type: ?[]const u8 = null,

    /// The ID of the Spot Instance request.
    spot_instance_request_id: ?[]const u8 = null,
};

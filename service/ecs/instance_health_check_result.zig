const InstanceHealthCheckState = @import("instance_health_check_state.zig").InstanceHealthCheckState;
const InstanceHealthCheckType = @import("instance_health_check_type.zig").InstanceHealthCheckType;

/// An object representing the result of a container instance health status
/// check.
pub const InstanceHealthCheckResult = struct {
    /// The Unix timestamp for when the container instance health status last
    /// changed.
    last_status_change: ?i64 = null,

    /// The Unix timestamp for when the container instance health status was last
    /// updated.
    last_updated: ?i64 = null,

    /// The container instance health status.
    status: ?InstanceHealthCheckState = null,

    /// The type of container instance health status that was verified.
    @"type": ?InstanceHealthCheckType = null,

    pub const json_field_names = .{
        .last_status_change = "lastStatusChange",
        .last_updated = "lastUpdated",
        .status = "status",
        .@"type" = "type",
    };
};

const InstanceHealthCheckResult = @import("instance_health_check_result.zig").InstanceHealthCheckResult;
const InstanceHealthCheckState = @import("instance_health_check_state.zig").InstanceHealthCheckState;

/// An object representing the health status of the container instance.
pub const ContainerInstanceHealthStatus = struct {
    /// An array of objects representing the details of the container instance
    /// health status.
    details: ?[]const InstanceHealthCheckResult = null,

    /// The overall health status of the container instance. This is an aggregate
    /// status of all container instance health checks.
    overall_status: ?InstanceHealthCheckState = null,

    pub const json_field_names = .{
        .details = "details",
        .overall_status = "overallStatus",
    };
};

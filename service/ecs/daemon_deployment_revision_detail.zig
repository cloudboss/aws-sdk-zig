const DaemonDeploymentCapacityProvider = @import("daemon_deployment_capacity_provider.zig").DaemonDeploymentCapacityProvider;

/// Details about a daemon revision during a deployment, including running and
/// draining instance counts per capacity provider.
pub const DaemonDeploymentRevisionDetail = struct {
    /// The Amazon Resource Name (ARN) of the daemon revision.
    arn: ?[]const u8 = null,

    /// The capacity providers associated with this daemon revision during the
    /// deployment.
    capacity_providers: ?[]const DaemonDeploymentCapacityProvider = null,

    /// The total number of instances being drained for this revision during the
    /// deployment.
    total_draining_instance_count: ?i32 = null,

    /// The total number of instances running daemon tasks for this revision.
    total_running_instance_count: ?i32 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .capacity_providers = "capacityProviders",
        .total_draining_instance_count = "totalDrainingInstanceCount",
        .total_running_instance_count = "totalRunningInstanceCount",
    };
};

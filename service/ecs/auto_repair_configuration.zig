const AutoRepairActionsStatus = @import("auto_repair_actions_status.zig").AutoRepairActionsStatus;

/// The auto repair configuration for an Amazon ECS Managed Instances capacity
/// provider. When enabled, Amazon ECS automatically replaces container
/// instances that are detected as unhealthy based on container instance health
/// checks, including accelerated compute device and daemon health checks.
pub const AutoRepairConfiguration = struct {
    /// The status of auto repair actions for the capacity provider. When set to
    /// `ENABLED`, Amazon ECS automatically replaces container instances with an
    /// `IMPAIRED` health status. When set to `DISABLED`, Amazon ECS still monitors
    /// container instance health but does not automatically replace impaired
    /// instances.
    actions_status: ?AutoRepairActionsStatus = null,

    pub const json_field_names = .{
        .actions_status = "actionsStatus",
    };
};

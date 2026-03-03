const ComputeQuotaResourceConfig = @import("compute_quota_resource_config.zig").ComputeQuotaResourceConfig;
const PreemptTeamTasks = @import("preempt_team_tasks.zig").PreemptTeamTasks;
const ResourceSharingConfig = @import("resource_sharing_config.zig").ResourceSharingConfig;

/// Configuration of the compute allocation definition for an entity. This
/// includes the resource sharing option and the setting to preempt low priority
/// tasks.
pub const ComputeQuotaConfig = struct {
    /// Allocate compute resources by instance types.
    compute_quota_resources: ?[]const ComputeQuotaResourceConfig = null,

    /// Allows workloads from within an entity to preempt same-team workloads. When
    /// set to `LowerPriority`, the entity's lower priority tasks are preempted by
    /// their own higher priority tasks.
    ///
    /// Default is `LowerPriority`.
    preempt_team_tasks: ?PreemptTeamTasks = null,

    /// Resource sharing configuration. This defines how an entity can lend and
    /// borrow idle compute with other entities within the cluster.
    resource_sharing_config: ?ResourceSharingConfig = null,

    pub const json_field_names = .{
        .compute_quota_resources = "ComputeQuotaResources",
        .preempt_team_tasks = "PreemptTeamTasks",
        .resource_sharing_config = "ResourceSharingConfig",
    };
};

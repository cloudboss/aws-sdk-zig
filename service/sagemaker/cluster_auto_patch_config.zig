const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const ClusterPatchingStrategy = @import("cluster_patching_strategy.zig").ClusterPatchingStrategy;
const ClusterPatchSchedule = @import("cluster_patch_schedule.zig").ClusterPatchSchedule;

/// The configuration for automatic patching of the instance group. When
/// configured, the system automatically applies security patch AMI updates to
/// the instance group.
pub const ClusterAutoPatchConfig = struct {
    /// The deployment configuration for rolling patch updates, including rollback
    /// settings and batch sizes. Only applicable when using a rolling patching
    /// strategy.
    deployment_config: ?DeploymentConfiguration = null,

    /// The strategy for applying patches to instances in the group.
    ///
    /// * `WhenIdle`: Cordons all instances and patches each instance as it becomes
    ///   idle (no running jobs). Each instance is uncordoned immediately after
    ///   patching and becomes available for new jobs. If instances do not become
    ///   idle, they remain on the previous AMI version. You can then use
    ///   UpdateClusterSoftware with the desired ImageReleaseVersion to manually
    ///   update the remaining instances.
    /// * `WhenAllIdle`: Cordons all instances and waits for all to become idle
    ///   before patching. All instances are uncordoned after patching completes. If
    ///   not all instances become idle, no patching occurs and all instances remain
    ///   on the previous AMI version.
    patching_strategy: ClusterPatchingStrategy,

    /// The schedule for automatic patching, including the next patch date.
    patch_schedule: ?ClusterPatchSchedule = null,

    pub const json_field_names = .{
        .deployment_config = "DeploymentConfig",
        .patching_strategy = "PatchingStrategy",
        .patch_schedule = "PatchSchedule",
    };
};

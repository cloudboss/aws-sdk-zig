const ClusterPatchScheduleDetails = @import("cluster_patch_schedule_details.zig").ClusterPatchScheduleDetails;
const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const ClusterPatchingStrategy = @import("cluster_patching_strategy.zig").ClusterPatchingStrategy;

/// The auto-patching configuration details for the instance group, including
/// the patching strategy and schedule.
pub const ClusterAutoPatchConfigDetails = struct {
    /// The currently active patch schedule that the system will execute.
    current_patch_schedule: ?ClusterPatchScheduleDetails = null,

    /// The deployment configuration for rolling patch updates.
    deployment_config: ?DeploymentConfiguration = null,

    /// The requested patch schedule. Differs from CurrentPatchSchedule when a
    /// reschedule request is pending.
    desired_patch_schedule: ?ClusterPatchScheduleDetails = null,

    /// The strategy used for applying patches to instances in the group.
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
    patching_strategy: ?ClusterPatchingStrategy = null,

    pub const json_field_names = .{
        .current_patch_schedule = "CurrentPatchSchedule",
        .deployment_config = "DeploymentConfig",
        .desired_patch_schedule = "DesiredPatchSchedule",
        .patching_strategy = "PatchingStrategy",
    };
};

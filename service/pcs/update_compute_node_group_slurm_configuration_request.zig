const aws = @import("aws");

const SlurmCustomSetting = @import("slurm_custom_setting.zig").SlurmCustomSetting;

/// Additional options related to the Slurm scheduler.
pub const UpdateComputeNodeGroupSlurmConfigurationRequest = struct {
    /// The additional Slurm `gres.conf` records for the compute node group. Each
    /// item is a map of `gres.conf` attribute names to values that describes one
    /// `gres.conf` record, such as a GPU topology, MIG, MPS, or custom GRES entry.
    /// PCS adds the `NodeName=` prefix and merges these records with the GPU record
    /// it derives from the instance type.
    gres_custom_settings: ?[]const []const aws.map.StringMapEntry = null,

    /// The time (in seconds) before an idle node is scaled down. If not specified,
    /// the cluster-level setting applies. This overrides the cluster-level
    /// `scaleDownIdleTimeInSeconds` setting. A value of `-1` removes the override
    /// and applies the cluster-level setting to this compute node group. Requires
    /// Slurm version 25.11 or later.
    scale_down_idle_time_in_seconds: ?i32 = null,

    /// Additional Slurm-specific configuration that directly maps to Slurm
    /// settings.
    slurm_custom_settings: ?[]const SlurmCustomSetting = null,

    pub const json_field_names = .{
        .gres_custom_settings = "gresCustomSettings",
        .scale_down_idle_time_in_seconds = "scaleDownIdleTimeInSeconds",
        .slurm_custom_settings = "slurmCustomSettings",
    };
};

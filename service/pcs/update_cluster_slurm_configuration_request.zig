const UpdateAccountingRequest = @import("update_accounting_request.zig").UpdateAccountingRequest;
const SlurmCustomSetting = @import("slurm_custom_setting.zig").SlurmCustomSetting;
const UpdateSlurmRestRequest = @import("update_slurm_rest_request.zig").UpdateSlurmRestRequest;

/// Additional options related to the Slurm scheduler.
pub const UpdateClusterSlurmConfigurationRequest = struct {
    /// The accounting configuration includes configurable settings for Slurm
    /// accounting.
    accounting: ?UpdateAccountingRequest = null,

    /// The time (in seconds) before an idle node is scaled down.
    ///
    /// Default: `600`
    scale_down_idle_time_in_seconds: ?i32 = null,

    /// Additional Slurm-specific configuration that directly maps to Slurm
    /// settings.
    slurm_custom_settings: ?[]const SlurmCustomSetting = null,

    /// The Slurm REST API configuration for the cluster.
    slurm_rest: ?UpdateSlurmRestRequest = null,

    pub const json_field_names = .{
        .accounting = "accounting",
        .scale_down_idle_time_in_seconds = "scaleDownIdleTimeInSeconds",
        .slurm_custom_settings = "slurmCustomSettings",
        .slurm_rest = "slurmRest",
    };
};

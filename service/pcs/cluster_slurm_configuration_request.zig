const AccountingRequest = @import("accounting_request.zig").AccountingRequest;
const SlurmCustomSetting = @import("slurm_custom_setting.zig").SlurmCustomSetting;
const SlurmRestRequest = @import("slurm_rest_request.zig").SlurmRestRequest;

/// Additional options related to the Slurm scheduler.
pub const ClusterSlurmConfigurationRequest = struct {
    /// The accounting configuration includes configurable settings for Slurm
    /// accounting.
    accounting: ?AccountingRequest = null,

    /// The time (in seconds) before an idle node is scaled down.
    ///
    /// Default: `600`
    scale_down_idle_time_in_seconds: ?i32 = null,

    /// Additional Slurm-specific configuration that directly maps to Slurm
    /// settings.
    slurm_custom_settings: ?[]const SlurmCustomSetting = null,

    /// The Slurm REST API configuration for the cluster.
    slurm_rest: ?SlurmRestRequest = null,

    pub const json_field_names = .{
        .accounting = "accounting",
        .scale_down_idle_time_in_seconds = "scaleDownIdleTimeInSeconds",
        .slurm_custom_settings = "slurmCustomSettings",
        .slurm_rest = "slurmRest",
    };
};

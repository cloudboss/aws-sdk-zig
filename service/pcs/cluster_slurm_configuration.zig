const Accounting = @import("accounting.zig").Accounting;
const SlurmAuthKey = @import("slurm_auth_key.zig").SlurmAuthKey;
const JwtAuth = @import("jwt_auth.zig").JwtAuth;
const SlurmCustomSetting = @import("slurm_custom_setting.zig").SlurmCustomSetting;
const SlurmRest = @import("slurm_rest.zig").SlurmRest;

/// Additional options related to the Slurm scheduler.
pub const ClusterSlurmConfiguration = struct {
    /// The accounting configuration includes configurable settings for Slurm
    /// accounting.
    accounting: ?Accounting = null,

    /// The shared Slurm key for authentication, also known as the **cluster
    /// secret**.
    auth_key: ?SlurmAuthKey = null,

    /// The JWT authentication configuration for Slurm REST API access.
    jwt_auth: ?JwtAuth = null,

    /// The time (in seconds) before an idle node is scaled down.
    ///
    /// Default: `600`
    scale_down_idle_time_in_seconds: ?i32 = null,

    /// Additional Slurm-specific configuration that directly maps to Slurm
    /// settings.
    slurm_custom_settings: ?[]const SlurmCustomSetting = null,

    /// The Slurm REST API configuration for the cluster.
    slurm_rest: ?SlurmRest = null,

    pub const json_field_names = .{
        .accounting = "accounting",
        .auth_key = "authKey",
        .jwt_auth = "jwtAuth",
        .scale_down_idle_time_in_seconds = "scaleDownIdleTimeInSeconds",
        .slurm_custom_settings = "slurmCustomSettings",
        .slurm_rest = "slurmRest",
    };
};

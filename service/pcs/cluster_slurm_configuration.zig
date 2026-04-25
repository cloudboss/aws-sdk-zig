const Accounting = @import("accounting.zig").Accounting;
const SlurmAuthKey = @import("slurm_auth_key.zig").SlurmAuthKey;
const CgroupCustomSetting = @import("cgroup_custom_setting.zig").CgroupCustomSetting;
const JwtAuth = @import("jwt_auth.zig").JwtAuth;
const SlurmCustomSetting = @import("slurm_custom_setting.zig").SlurmCustomSetting;
const SlurmdbdCustomSetting = @import("slurmdbd_custom_setting.zig").SlurmdbdCustomSetting;
const SlurmRest = @import("slurm_rest.zig").SlurmRest;

/// Additional options related to the Slurm scheduler.
pub const ClusterSlurmConfiguration = struct {
    /// The accounting configuration includes configurable settings for Slurm
    /// accounting.
    accounting: ?Accounting = null,

    /// The shared Slurm key for authentication, also known as the **cluster
    /// secret**.
    auth_key: ?SlurmAuthKey = null,

    /// Additional Cgroup-specific configuration that directly maps to Cgroup
    /// settings.
    cgroup_custom_settings: ?[]const CgroupCustomSetting = null,

    /// The JWT authentication configuration for Slurm REST API access.
    jwt_auth: ?JwtAuth = null,

    /// The time (in seconds) before an idle node is scaled down.
    ///
    /// Default: `600`
    scale_down_idle_time_in_seconds: ?i32 = null,

    /// Additional Slurm-specific configuration that directly maps to Slurm
    /// settings.
    slurm_custom_settings: ?[]const SlurmCustomSetting = null,

    /// Additional SlurmDBD-specific configuration that directly maps to SlurmDBD
    /// settings.
    slurmdbd_custom_settings: ?[]const SlurmdbdCustomSetting = null,

    /// The Slurm REST API configuration for the cluster.
    slurm_rest: ?SlurmRest = null,

    pub const json_field_names = .{
        .accounting = "accounting",
        .auth_key = "authKey",
        .cgroup_custom_settings = "cgroupCustomSettings",
        .jwt_auth = "jwtAuth",
        .scale_down_idle_time_in_seconds = "scaleDownIdleTimeInSeconds",
        .slurm_custom_settings = "slurmCustomSettings",
        .slurmdbd_custom_settings = "slurmdbdCustomSettings",
        .slurm_rest = "slurmRest",
    };
};

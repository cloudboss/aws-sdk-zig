const SlurmCustomSetting = @import("slurm_custom_setting.zig").SlurmCustomSetting;

/// Additional options related to the Slurm scheduler.
pub const ComputeNodeGroupSlurmConfigurationRequest = struct {
    /// Additional Slurm-specific configuration that directly maps to Slurm
    /// settings.
    slurm_custom_settings: ?[]const SlurmCustomSetting,

    pub const json_field_names = .{
        .slurm_custom_settings = "slurmCustomSettings",
    };
};

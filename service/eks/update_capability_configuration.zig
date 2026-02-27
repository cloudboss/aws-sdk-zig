const UpdateArgoCdConfig = @import("update_argo_cd_config.zig").UpdateArgoCdConfig;

/// Configuration updates for a capability. The structure varies depending on
/// the capability type.
pub const UpdateCapabilityConfiguration = struct {
    /// Configuration updates specific to Argo CD capabilities.
    argo_cd: ?UpdateArgoCdConfig,

    pub const json_field_names = .{
        .argo_cd = "argoCd",
    };
};

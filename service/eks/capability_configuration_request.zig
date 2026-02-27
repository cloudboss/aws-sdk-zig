const ArgoCdConfigRequest = @import("argo_cd_config_request.zig").ArgoCdConfigRequest;

/// Configuration settings for a capability. The structure of this object varies
/// depending on the capability type.
pub const CapabilityConfigurationRequest = struct {
    /// Configuration settings specific to Argo CD capabilities. This field is only
    /// used when creating or updating an Argo CD capability.
    argo_cd: ?ArgoCdConfigRequest,

    pub const json_field_names = .{
        .argo_cd = "argoCd",
    };
};

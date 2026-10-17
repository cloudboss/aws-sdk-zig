const AckConfigResponse = @import("ack_config_response.zig").AckConfigResponse;
const ArgoCdConfigResponse = @import("argo_cd_config_response.zig").ArgoCdConfigResponse;

/// The response object containing capability configuration details.
pub const CapabilityConfigurationResponse = struct {
    /// Configuration settings for an ACK (Amazon Web Services Controllers for
    /// Kubernetes) capability, including the cross-namespace reference setting and
    /// the list of disabled services.
    ack: ?AckConfigResponse = null,

    /// Configuration settings for an Argo CD capability, including the server URL
    /// and other Argo CD-specific settings.
    argo_cd: ?ArgoCdConfigResponse = null,

    pub const json_field_names = .{
        .ack = "ack",
        .argo_cd = "argoCd",
    };
};

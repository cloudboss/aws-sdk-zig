const UpdateAckConfig = @import("update_ack_config.zig").UpdateAckConfig;
const UpdateArgoCdConfig = @import("update_argo_cd_config.zig").UpdateArgoCdConfig;

/// Configuration updates for a capability. The structure varies depending on
/// the capability type.
pub const UpdateCapabilityConfiguration = struct {
    /// Configuration updates specific to ACK (Amazon Web Services Controllers for
    /// Kubernetes) capabilities.
    ack: ?UpdateAckConfig = null,

    /// Configuration updates specific to Argo CD capabilities.
    argo_cd: ?UpdateArgoCdConfig = null,

    pub const json_field_names = .{
        .ack = "ack",
        .argo_cd = "argoCd",
    };
};

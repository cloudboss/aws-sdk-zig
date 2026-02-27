const CACertificateUpdateAction = @import("ca_certificate_update_action.zig").CACertificateUpdateAction;

/// Parameters to define a mitigation action that changes the state of the CA
/// certificate to inactive.
pub const UpdateCACertificateParams = struct {
    /// The action that you want to apply to the CA certificate. The only supported
    /// value is `DEACTIVATE`.
    action: CACertificateUpdateAction,

    pub const json_field_names = .{
        .action = "action",
    };
};

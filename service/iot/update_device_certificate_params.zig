const DeviceCertificateUpdateAction = @import("device_certificate_update_action.zig").DeviceCertificateUpdateAction;

/// Parameters to define a mitigation action that changes the state of the
/// device certificate to inactive.
pub const UpdateDeviceCertificateParams = struct {
    /// The action that you want to apply to the device certificate. The only
    /// supported value is `DEACTIVATE`.
    action: DeviceCertificateUpdateAction,

    pub const json_field_names = .{
        .action = "action",
    };
};

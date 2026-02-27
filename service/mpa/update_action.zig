/// Actions that can be taken when updating an approval team
///
/// * `SYNCHRONIZE_MFA_DEVICES`: Synchronize MFA devices for all approvers on
///   the team
pub const UpdateAction = enum {
    synchronize_mfa_devices,

    pub const json_field_names = .{
        .synchronize_mfa_devices = "SYNCHRONIZE_MFA_DEVICES",
    };
};

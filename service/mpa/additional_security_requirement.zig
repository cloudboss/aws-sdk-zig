/// Additional security requirements applied to a session or invitation
///
/// * `APPROVER_VERIFICATION_REQUIRED`: Approvers will be required to perform an
///   MFA challenge to vote
pub const AdditionalSecurityRequirement = enum {
    approver_verification_required,

    pub const json_field_names = .{
        .approver_verification_required = "APPROVER_VERIFICATION_REQUIRED",
    };
};

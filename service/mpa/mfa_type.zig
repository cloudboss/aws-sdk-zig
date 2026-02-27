/// The type of MFA device used by the approver
///
/// * `EMAIL_OTP`: The approver will receive emailed one-time passwords to their
///   primary email
pub const MfaType = enum {
    email_otp,

    pub const json_field_names = .{
        .email_otp = "EMAIL_OTP",
    };
};

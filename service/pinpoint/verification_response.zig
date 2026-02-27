/// Verify OTP Message Response.
pub const VerificationResponse = struct {
    /// Specifies whether the OTP is valid or not.
    valid: ?bool,

    pub const json_field_names = .{
        .valid = "Valid",
    };
};

/// Verify OTP message request.
pub const VerifyOTPMessageRequestParameters = struct {
    /// The destination identity to send OTP to.
    destination_identity: []const u8,

    /// The OTP the end user provided for verification.
    otp: []const u8,

    /// The reference identifier provided when the OTP was previously sent.
    reference_id: []const u8,

    pub const json_field_names = .{
        .destination_identity = "DestinationIdentity",
        .otp = "Otp",
        .reference_id = "ReferenceId",
    };
};

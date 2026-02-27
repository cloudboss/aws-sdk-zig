/// Parameters that are required to generate or verify Visa PIN.
pub const VisaPinVerification = struct {
    /// The value for PIN verification index. It is used in the Visa PIN algorithm
    /// to calculate the PVV (PIN Verification Value).
    pin_verification_key_index: i32,

    /// Parameters that are required to generate or verify Visa PVV (PIN
    /// Verification Value).
    verification_value: []const u8,

    pub const json_field_names = .{
        .pin_verification_key_index = "PinVerificationKeyIndex",
        .verification_value = "VerificationValue",
    };
};

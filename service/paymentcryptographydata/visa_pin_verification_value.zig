/// Parameters that are required to generate or verify Visa PVV (PIN
/// Verification Value).
pub const VisaPinVerificationValue = struct {
    /// The encrypted PIN block data to verify.
    encrypted_pin_block: []const u8,

    /// The value for PIN verification index. It is used in the Visa PIN algorithm
    /// to calculate the PVV (PIN Verification Value).
    pin_verification_key_index: i32,

    pub const json_field_names = .{
        .encrypted_pin_block = "EncryptedPinBlock",
        .pin_verification_key_index = "PinVerificationKeyIndex",
    };
};

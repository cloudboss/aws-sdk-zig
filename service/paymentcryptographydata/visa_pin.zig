/// Parameters that are required to generate or verify Visa PIN.
pub const VisaPin = struct {
    /// The value for PIN verification index. It is used in the Visa PIN algorithm
    /// to calculate the PVV (PIN Verification Value).
    pin_verification_key_index: i32,

    pub const json_field_names = .{
        .pin_verification_key_index = "PinVerificationKeyIndex",
    };
};

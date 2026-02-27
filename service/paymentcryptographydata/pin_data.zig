/// Parameters that are required to generate, translate, or verify PIN data.
pub const PinData = union(enum) {
    /// The PIN offset value.
    pin_offset: ?[]const u8,
    /// The unique data to identify a cardholder. In most cases, this is the same as
    /// cardholder's Primary Account Number (PAN). If a value is not provided, it
    /// defaults to PAN.
    verification_value: ?[]const u8,

    pub const json_field_names = .{
        .pin_offset = "PinOffset",
        .verification_value = "VerificationValue",
    };
};

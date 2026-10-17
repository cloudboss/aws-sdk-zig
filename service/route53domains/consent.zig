/// The maximum amount that you agree to pay for an operation, and the
/// currency for that amount.
pub const Consent = struct {
    /// The currency for the `MaxPrice`.
    currency: []const u8,

    /// The maximum amount that you agree to accept.
    max_price: f64 = 0,

    pub const json_field_names = .{
        .currency = "Currency",
        .max_price = "MaxPrice",
    };
};

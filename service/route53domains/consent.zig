/// Customer's consent for the owner change request.
pub const Consent = struct {
    /// Currency for the `MaxPrice`.
    currency: []const u8,

    /// Maximum amount the customer agreed to accept.
    max_price: f64 = 0,

    pub const json_field_names = .{
        .currency = "Currency",
        .max_price = "MaxPrice",
    };
};

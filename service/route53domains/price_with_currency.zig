/// Currency-specific price information.
pub const PriceWithCurrency = struct {
    /// The currency specifier.
    currency: []const u8,

    /// The price of a domain, in a specific currency.
    price: f64 = 0,

    pub const json_field_names = .{
        .currency = "Currency",
        .price = "Price",
    };
};

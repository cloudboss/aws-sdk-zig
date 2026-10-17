const PriceType = @import("price_type.zig").PriceType;

/// Currency-specific price information.
pub const PriceWithCurrency = struct {
    /// The currency specifier.
    currency: []const u8,

    /// The price of a domain, in a specific currency.
    price: f64 = 0,

    /// Indicates whether the domain has standard or premium pricing. A value of
    /// `STANDARD` means the domain is priced at the regular rate for its TLD. A
    /// value of `REGISTRY_PREMIUM` means the domain has registry premium pricing,
    /// which may be different than the standard rate.
    price_type: ?PriceType = null,

    pub const json_field_names = .{
        .currency = "Currency",
        .price = "Price",
        .price_type = "PriceType",
    };
};

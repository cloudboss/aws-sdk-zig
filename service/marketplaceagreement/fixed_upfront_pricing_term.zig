const GrantItem = @import("grant_item.zig").GrantItem;

/// Defines a prepaid pricing model where the customers are charged a fixed
/// upfront amount.
pub const FixedUpfrontPricingTerm = struct {
    /// Defines the currency for the prices mentioned in this term.
    currency_code: ?[]const u8 = null,

    /// Contract duration for the terms.
    duration: ?[]const u8 = null,

    /// Entitlements granted to the acceptor of fixed upfront as part of agreement
    /// execution.
    grants: ?[]const GrantItem = null,

    /// Fixed amount to be charged to the customer when this term is accepted.
    price: ?[]const u8 = null,

    /// Category of the term being updated.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .duration = "duration",
        .grants = "grants",
        .price = "price",
        .@"type" = "type",
    };
};

const GrantItem = @import("grant_item.zig").GrantItem;
const TermType = @import("term_type.zig").TermType;

/// Defines a fixed upfront pricing term with a pre-paid amount and granted
/// entitlements.
pub const FixedUpfrontPricingTerm = struct {
    /// Defines the currency for the prices in this term.
    currency_code: []const u8,

    /// The duration of the fixed pricing term, in ISO 8601 format.
    duration: ?[]const u8 = null,

    /// The entitlements granted to the buyer as part of this term.
    grants: []const GrantItem,

    /// The unique identifier of the term.
    id: []const u8,

    /// The price charged upfront for this term.
    price: []const u8,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .currency_code = "currencyCode",
        .duration = "duration",
        .grants = "grants",
        .id = "id",
        .price = "price",
        .type = "type",
    };
};

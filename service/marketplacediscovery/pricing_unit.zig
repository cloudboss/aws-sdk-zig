const PricingUnitType = @import("pricing_unit_type.zig").PricingUnitType;

/// A pricing unit that defines the billing dimension for a listing, such as
/// users, hosts, bandwidth, or data.
pub const PricingUnit = struct {
    /// The human-readable name of the pricing unit.
    display_name: []const u8,

    /// The machine-readable type of the pricing unit.
    pricing_unit_type: PricingUnitType,

    pub const json_field_names = .{
        .display_name = "displayName",
        .pricing_unit_type = "pricingUnitType",
    };
};

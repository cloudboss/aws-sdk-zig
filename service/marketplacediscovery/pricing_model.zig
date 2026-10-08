const PricingModelType = @import("pricing_model_type.zig").PricingModelType;

/// A pricing model that determines how buyers are charged for a listing, such
/// as usage-based, contract, BYOL, or free.
pub const PricingModel = struct {
    /// The human-readable name of the pricing model.
    display_name: []const u8,

    /// The machine-readable type of the pricing model.
    pricing_model_type: PricingModelType,

    pub const json_field_names = .{
        .display_name = "displayName",
        .pricing_model_type = "pricingModelType",
    };
};

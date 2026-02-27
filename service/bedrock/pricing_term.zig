const DimensionalPriceRate = @import("dimensional_price_rate.zig").DimensionalPriceRate;

/// Describes the usage-based pricing term.
pub const PricingTerm = struct {
    /// Describes a usage price for each dimension.
    rate_card: []const DimensionalPriceRate,

    pub const json_field_names = .{
        .rate_card = "rateCard",
    };
};

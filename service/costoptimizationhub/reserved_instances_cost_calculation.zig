const ReservedInstancesPricing = @import("reserved_instances_pricing.zig").ReservedInstancesPricing;

/// Cost impact of the purchase recommendation.
pub const ReservedInstancesCostCalculation = struct {
    /// Pricing details of the purchase recommendation.
    pricing: ?ReservedInstancesPricing = null,

    pub const json_field_names = .{
        .pricing = "pricing",
    };
};

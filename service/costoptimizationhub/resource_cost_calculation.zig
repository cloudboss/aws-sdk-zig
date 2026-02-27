const ResourcePricing = @import("resource_pricing.zig").ResourcePricing;
const Usage = @import("usage.zig").Usage;

/// Cost impact of the resource recommendation.
pub const ResourceCostCalculation = struct {
    /// Pricing details of the resource recommendation.
    pricing: ?ResourcePricing,

    /// Usage details of the resource recommendation.
    usages: ?[]const Usage,

    pub const json_field_names = .{
        .pricing = "pricing",
        .usages = "usages",
    };
};

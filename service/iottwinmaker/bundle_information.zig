const PricingTier = @import("pricing_tier.zig").PricingTier;

/// Information about the pricing bundle.
pub const BundleInformation = struct {
    /// The bundle names.
    bundle_names: []const []const u8,

    /// The pricing tier.
    pricing_tier: ?PricingTier = null,

    pub const json_field_names = .{
        .bundle_names = "bundleNames",
        .pricing_tier = "pricingTier",
    };
};

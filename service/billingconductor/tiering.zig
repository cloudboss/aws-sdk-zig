const CustomTier = @import("custom_tier.zig").CustomTier;
const FreeTierConfig = @import("free_tier_config.zig").FreeTierConfig;

/// The set of tiering configurations for the pricing rule.
pub const Tiering = struct {
    /// The set of custom tiers for the pricing rule.
    custom_tiers: ?[]const CustomTier = null,

    /// The possible Amazon Web Services Free Tier configurations.
    free_tier: ?FreeTierConfig = null,

    pub const json_field_names = .{
        .custom_tiers = "CustomTiers",
        .free_tier = "FreeTier",
    };
};

const CustomTier = @import("custom_tier.zig").CustomTier;
const UpdateFreeTierConfig = @import("update_free_tier_config.zig").UpdateFreeTierConfig;

/// The set of tiering configurations for the pricing rule.
pub const UpdateTieringInput = struct {
    /// The set of custom tiers for the pricing rule.
    custom_tiers: ?[]const CustomTier = null,

    /// The possible Amazon Web Services Free Tier configurations.
    free_tier: ?UpdateFreeTierConfig = null,

    pub const json_field_names = .{
        .custom_tiers = "CustomTiers",
        .free_tier = "FreeTier",
    };
};

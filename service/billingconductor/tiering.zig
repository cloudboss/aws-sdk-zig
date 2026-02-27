const FreeTierConfig = @import("free_tier_config.zig").FreeTierConfig;

/// The set of tiering configurations for the pricing rule.
pub const Tiering = struct {
    /// The possible Amazon Web Services Free Tier configurations.
    free_tier: FreeTierConfig,

    pub const json_field_names = .{
        .free_tier = "FreeTier",
    };
};

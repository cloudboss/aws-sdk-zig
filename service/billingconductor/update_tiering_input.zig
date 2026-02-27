const UpdateFreeTierConfig = @import("update_free_tier_config.zig").UpdateFreeTierConfig;

/// The set of tiering configurations for the pricing rule.
pub const UpdateTieringInput = struct {
    /// The possible Amazon Web Services Free Tier configurations.
    free_tier: UpdateFreeTierConfig,

    pub const json_field_names = .{
        .free_tier = "FreeTier",
    };
};

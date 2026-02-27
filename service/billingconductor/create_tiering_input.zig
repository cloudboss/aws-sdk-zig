const CreateFreeTierConfig = @import("create_free_tier_config.zig").CreateFreeTierConfig;

/// The set of tiering configurations for the pricing rule.
pub const CreateTieringInput = struct {
    /// The possible Amazon Web Services Free Tier configurations.
    free_tier: CreateFreeTierConfig,

    pub const json_field_names = .{
        .free_tier = "FreeTier",
    };
};

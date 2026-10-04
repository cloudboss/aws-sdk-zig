const AbandonmentRatePacingConfig = @import("abandonment_rate_pacing_config.zig").AbandonmentRatePacingConfig;

/// Pacing constraint the dialer may enforce.
pub const PacingStrategy = union(enum) {
    abandonment_rate: ?AbandonmentRatePacingConfig,

    pub const json_field_names = .{
        .abandonment_rate = "abandonmentRate",
    };
};

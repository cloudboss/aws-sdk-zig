const PacingStrategy = @import("pacing_strategy.zig").PacingStrategy;

/// Predictive config
pub const PredictiveConfig = struct {
    bandwidth_allocation: f64,

    /// Pacing strategies the dialer enforces simultaneously.
    pacing_strategies: ?[]const PacingStrategy = null,

    pub const json_field_names = .{
        .bandwidth_allocation = "bandwidthAllocation",
        .pacing_strategies = "pacingStrategies",
    };
};

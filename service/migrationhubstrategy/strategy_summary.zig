const Strategy = @import("strategy.zig").Strategy;

/// Object containing the summary of the strategy recommendations.
pub const StrategySummary = struct {
    /// The count of recommendations per strategy.
    count: ?i32 = null,

    /// The name of recommended strategy.
    strategy: ?Strategy = null,

    pub const json_field_names = .{
        .count = "count",
        .strategy = "strategy",
    };
};

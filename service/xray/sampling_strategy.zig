const SamplingStrategyName = @import("sampling_strategy_name.zig").SamplingStrategyName;

/// The name and value of a sampling rule to apply to a trace summary.
pub const SamplingStrategy = struct {
    /// The name of a sampling rule.
    name: ?SamplingStrategyName,

    /// The value of a sampling rule.
    value: ?f64,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};

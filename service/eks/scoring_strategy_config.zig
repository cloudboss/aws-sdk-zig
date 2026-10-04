const ScoringStrategyConstraints = @import("scoring_strategy_constraints.zig").ScoringStrategyConstraints;
const ScoringStrategy = @import("scoring_strategy.zig").ScoringStrategy;

/// The scoring strategy configuration with default value and constraints.
pub const ScoringStrategyConfig = struct {
    /// The constraints for the scoring strategy.
    constraints: ?ScoringStrategyConstraints = null,

    /// The default scoring strategy.
    default_value: ?ScoringStrategy = null,

    pub const json_field_names = .{
        .constraints = "constraints",
        .default_value = "defaultValue",
    };
};

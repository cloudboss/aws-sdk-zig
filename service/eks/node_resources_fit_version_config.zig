const ScoringStrategyConfig = @import("scoring_strategy_config.zig").ScoringStrategyConfig;

/// The NodeResourcesFit version configuration with default value and
/// constraints.
pub const NodeResourcesFitVersionConfig = struct {
    /// The scoring strategy configuration with default value and constraints.
    scoring_strategy: ?ScoringStrategyConfig = null,

    pub const json_field_names = .{
        .scoring_strategy = "scoringStrategy",
    };
};

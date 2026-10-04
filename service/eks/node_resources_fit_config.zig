const ScoringStrategy = @import("scoring_strategy.zig").ScoringStrategy;

/// The NodeResourcesFit plugin configuration for the Kubernetes scheduler.
pub const NodeResourcesFitConfig = struct {
    /// The scoring strategy used to rank nodes during scheduling.
    scoring_strategy: ?ScoringStrategy = null,

    pub const json_field_names = .{
        .scoring_strategy = "scoringStrategy",
    };
};

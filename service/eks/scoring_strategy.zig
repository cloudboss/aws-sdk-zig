const ResourceWeight = @import("resource_weight.zig").ResourceWeight;
const ScoringStrategyType = @import("scoring_strategy_type.zig").ScoringStrategyType;

/// The scoring strategy configuration for the NodeResourcesFit scheduler
/// plugin.
pub const ScoringStrategy = struct {
    /// The resource weights used for scoring nodes.
    resources: ?[]const ResourceWeight = null,

    /// The scoring strategy type. Valid values are `LeastAllocated` or
    /// `MostAllocated`.
    type: ?ScoringStrategyType = null,

    pub const json_field_names = .{
        .resources = "resources",
        .type = "type",
    };
};

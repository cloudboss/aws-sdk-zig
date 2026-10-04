const ResourceConstraints = @import("resource_constraints.zig").ResourceConstraints;
const AllowedValuesConstraint = @import("allowed_values_constraint.zig").AllowedValuesConstraint;

/// Constraints for the scoring strategy configuration.
pub const ScoringStrategyConstraints = struct {
    /// The constraints for resource weights.
    resources: ?ResourceConstraints = null,

    /// The allowed values for the scoring strategy type.
    scoring_strategy: ?AllowedValuesConstraint = null,

    pub const json_field_names = .{
        .resources = "resources",
        .scoring_strategy = "scoringStrategy",
    };
};

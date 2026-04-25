const AIRecommendationConstraint = @import("ai_recommendation_constraint.zig").AIRecommendationConstraint;

/// The performance targets for an AI recommendation job.
pub const AIRecommendationPerformanceTarget = struct {
    /// An array of performance constraints that define the optimization objectives.
    constraints: []const AIRecommendationConstraint,

    pub const json_field_names = .{
        .constraints = "Constraints",
    };
};

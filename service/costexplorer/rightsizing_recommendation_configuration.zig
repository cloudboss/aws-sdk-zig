const RecommendationTarget = @import("recommendation_target.zig").RecommendationTarget;

/// You can use `RightsizingRecommendationConfiguration` to customize
/// recommendations across two attributes. You can choose to view
/// recommendations for
/// instances within the same instance families or across different instance
/// families. You
/// can also choose to view your estimated savings that are associated with
/// recommendations
/// with consideration of existing Savings Plans or Reserved Instance (RI)
/// benefits, or
/// neither.
pub const RightsizingRecommendationConfiguration = struct {
    /// The option to consider RI or Savings Plans discount benefits in your savings
    /// calculation. The default value is `TRUE`.
    benefits_considered: bool = false,

    /// The option to see recommendations within the same instance family or
    /// recommendations
    /// for instances across other families. The default value is
    /// `SAME_INSTANCE_FAMILY`.
    recommendation_target: RecommendationTarget,

    pub const json_field_names = .{
        .benefits_considered = "BenefitsConsidered",
        .recommendation_target = "RecommendationTarget",
    };
};

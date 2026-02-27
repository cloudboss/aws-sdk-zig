const GroupingRecommendationRejectionReason = @import("grouping_recommendation_rejection_reason.zig").GroupingRecommendationRejectionReason;

/// Indicates the rejected grouping recommendation.
pub const RejectGroupingRecommendationEntry = struct {
    /// Indicates the identifier of the grouping recommendation.
    grouping_recommendation_id: []const u8,

    /// Indicates the reason you had selected while rejecting a grouping
    /// recommendation.
    rejection_reason: ?GroupingRecommendationRejectionReason,

    pub const json_field_names = .{
        .grouping_recommendation_id = "groupingRecommendationId",
        .rejection_reason = "rejectionReason",
    };
};

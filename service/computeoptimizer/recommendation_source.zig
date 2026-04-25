const RecommendationSourceType = @import("recommendation_source_type.zig").RecommendationSourceType;

/// Describes the source of a recommendation, such as an Amazon EC2 instance or
/// Auto Scaling group.
pub const RecommendationSource = struct {
    /// The Amazon Resource Name (ARN) of the recommendation source.
    recommendation_source_arn: ?[]const u8 = null,

    /// The resource type of the recommendation source.
    recommendation_source_type: ?RecommendationSourceType = null,

    pub const json_field_names = .{
        .recommendation_source_arn = "recommendationSourceArn",
        .recommendation_source_type = "recommendationSourceType",
    };
};

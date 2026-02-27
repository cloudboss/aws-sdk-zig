const RecommendationSourceType = @import("recommendation_source_type.zig").RecommendationSourceType;

/// Describes the source of a recommendation, such as an Amazon EC2 instance or
/// Amazon EC2 Auto Scaling group.
pub const RecommendationSource = struct {
    /// The Amazon Resource Name (ARN) of the recommendation source.
    recommendation_source_arn: ?[]const u8,

    /// The resource type of the recommendation source.
    recommendation_source_type: ?RecommendationSourceType,

    pub const json_field_names = .{
        .recommendation_source_arn = "recommendationSourceArn",
        .recommendation_source_type = "recommendationSourceType",
    };
};

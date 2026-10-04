const aws = @import("aws");

const ExclusionStatus = @import("exclusion_status.zig").ExclusionStatus;
const RecommendationPillar = @import("recommendation_pillar.zig").RecommendationPillar;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Summary of a Recommendation for a specific AWS Resource
pub const RecommendationForResourceSummary = struct {
    /// The AWS Resource ARN
    aws_resource_arn: []const u8,

    /// The Check ARN
    check_arn: []const u8,

    /// The exclusion status of the recommendation
    exclusion_status: ExclusionStatus,

    /// When the recommendation was last updated
    last_updated_at: i64,

    /// Metadata associated with the recommendation
    metadata: []const aws.map.StringMapEntry,

    /// The Pillars that the Recommendation is optimizing
    pillars: []const RecommendationPillar,

    /// The Recommendation ARN
    recommendation_arn: []const u8,

    /// The current status of the recommendation
    status: ResourceStatus,

    pub const json_field_names = .{
        .aws_resource_arn = "awsResourceArn",
        .check_arn = "checkArn",
        .exclusion_status = "exclusionStatus",
        .last_updated_at = "lastUpdatedAt",
        .metadata = "metadata",
        .pillars = "pillars",
        .recommendation_arn = "recommendationArn",
        .status = "status",
    };
};

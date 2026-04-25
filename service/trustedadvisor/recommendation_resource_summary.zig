const aws = @import("aws");

const ExclusionStatus = @import("exclusion_status.zig").ExclusionStatus;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Summary of a Recommendation Resource
pub const RecommendationResourceSummary = struct {
    /// The ARN of the Recommendation Resource
    arn: []const u8,

    /// The AWS resource identifier. There are certain checks that generate
    /// recommendation resources without an awsResourceId.
    aws_resource_id: []const u8,

    /// The exclusion status of the Recommendation Resource
    exclusion_status: ExclusionStatus = .included,

    /// The ID of the Recommendation Resource
    id: []const u8,

    /// When the Recommendation Resource was last updated
    last_updated_at: i64,

    /// Metadata associated with the Recommendation Resource
    metadata: []const aws.map.StringMapEntry,

    /// The Recommendation ARN
    recommendation_arn: []const u8,

    /// The AWS Region code that the Recommendation Resource is in
    region_code: []const u8,

    /// The current status of the Recommendation Resource
    status: ResourceStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .aws_resource_id = "awsResourceId",
        .exclusion_status = "exclusionStatus",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .metadata = "metadata",
        .recommendation_arn = "recommendationArn",
        .region_code = "regionCode",
        .status = "status",
    };
};

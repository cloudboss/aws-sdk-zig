const aws = @import("aws");

const RecommendationPillar = @import("recommendation_pillar.zig").RecommendationPillar;
const RecommendationSource = @import("recommendation_source.zig").RecommendationSource;

/// A summary of an AWS Trusted Advisor Check
pub const CheckSummary = struct {
    /// The ARN of the AWS Trusted Advisor Check
    arn: []const u8,

    /// The AWS Services that the Check applies to
    aws_services: []const []const u8,

    /// A description of what the AWS Trusted Advisor Check is monitoring
    description: []const u8,

    /// The unique identifier of the AWS Trusted Advisor Check
    id: []const u8,

    /// The column headings for the metadata returned in the resource
    metadata: []const aws.map.StringMapEntry,

    /// The name of the AWS Trusted Advisor Check
    name: []const u8,

    /// The Recommendation pillars that the AWS Trusted Advisor Check falls under
    pillars: []const RecommendationPillar,

    /// The source of the Recommendation
    source: RecommendationSource,

    pub const json_field_names = .{
        .arn = "arn",
        .aws_services = "awsServices",
        .description = "description",
        .id = "id",
        .metadata = "metadata",
        .name = "name",
        .pillars = "pillars",
        .source = "source",
    };
};

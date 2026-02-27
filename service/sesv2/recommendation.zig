const RecommendationImpact = @import("recommendation_impact.zig").RecommendationImpact;
const RecommendationStatus = @import("recommendation_status.zig").RecommendationStatus;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;

/// A recommendation generated for your account.
pub const Recommendation = struct {
    /// The first time this issue was encountered and the recommendation was
    /// generated.
    created_timestamp: ?i64,

    /// The recommendation description / disambiguator - e.g. `DKIM1` and `DKIM2`
    /// are different recommendations about your DKIM setup.
    description: ?[]const u8,

    /// The recommendation impact, with values like
    /// `HIGH` or `LOW`.
    impact: ?RecommendationImpact,

    /// The last time the recommendation was updated.
    last_updated_timestamp: ?i64,

    /// The resource affected by the recommendation,
    /// with values like `arn:aws:ses:us-east-1:123456789012:identity/example.com`.
    resource_arn: ?[]const u8,

    /// The recommendation status, with values like
    /// `OPEN` or `FIXED`.
    status: ?RecommendationStatus,

    /// The recommendation type, with values like `DKIM`,
    /// `SPF`, `DMARC`, `BIMI`, or `COMPLAINT`.
    type: ?RecommendationType,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .description = "Description",
        .impact = "Impact",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .resource_arn = "ResourceArn",
        .status = "Status",
        .type = "Type",
    };
};

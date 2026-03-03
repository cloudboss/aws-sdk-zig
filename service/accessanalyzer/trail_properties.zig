/// Contains details about the CloudTrail trail being analyzed to generate a
/// policy.
pub const TrailProperties = struct {
    /// Possible values are `true` or `false`. If set to `true`, IAM Access Analyzer
    /// retrieves CloudTrail data from all regions to analyze and generate a policy.
    all_regions: ?bool = null,

    /// Specifies the ARN of the trail. The format of a trail ARN is
    /// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`.
    cloud_trail_arn: []const u8,

    /// A list of regions to get CloudTrail data from and analyze to generate a
    /// policy.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .all_regions = "allRegions",
        .cloud_trail_arn = "cloudTrailArn",
        .regions = "regions",
    };
};

/// This object contains regions to set up the aggregator and an IAM
/// role to retrieve organization details.
pub const OrganizationAggregationSource = struct {
    /// If true, aggregate existing Config regions and future
    /// regions.
    all_aws_regions: bool = false,

    /// The source regions being aggregated.
    aws_regions: ?[]const []const u8 = null,

    /// ARN of the IAM role used to retrieve Amazon Web Services Organization
    /// details
    /// associated with the aggregator account.
    role_arn: []const u8,

    pub const json_field_names = .{
        .all_aws_regions = "AllAwsRegions",
        .aws_regions = "AwsRegions",
        .role_arn = "RoleArn",
    };
};

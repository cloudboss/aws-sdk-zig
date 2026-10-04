/// Configuration settings that define the scope of Amazon Web Services
/// resources to analyze for optimization recommendations.
pub const AggregationConfiguration = struct {
    /// The ARN of an IAM role to assume for resource analysis in this account.
    access_role_arn: []const u8,

    /// The Amazon Web Services account ID to analyze.
    account_id: []const u8,

    /// A list of Amazon Web Services Regions to include in the analysis.
    regions: []const []const u8,

    pub const json_field_names = .{
        .access_role_arn = "accessRoleArn",
        .account_id = "accountId",
        .regions = "regions",
    };
};

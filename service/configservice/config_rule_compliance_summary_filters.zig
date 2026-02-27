/// Filters the results based on the account IDs and
/// regions.
pub const ConfigRuleComplianceSummaryFilters = struct {
    /// The 12-digit account ID of the source account.
    account_id: ?[]const u8,

    /// The source region where the data is aggregated.
    aws_region: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aws_region = "AwsRegion",
    };
};

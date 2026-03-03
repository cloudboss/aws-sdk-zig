/// Filters the results based on account ID and region.
pub const AggregateConformancePackComplianceSummaryFilters = struct {
    /// The 12-digit Amazon Web Services account ID of the source account.
    account_id: ?[]const u8 = null,

    /// The source Amazon Web Services Region from where the data is aggregated.
    aws_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .aws_region = "AwsRegion",
    };
};

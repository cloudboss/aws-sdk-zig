/// A collection of accounts and regions.
pub const AccountAggregationSource = struct {
    /// The 12-digit account ID of the account being aggregated.
    account_ids: []const []const u8,

    /// If true, aggregate existing Config regions and future
    /// regions.
    all_aws_regions: bool = false,

    /// The source regions being aggregated.
    aws_regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .all_aws_regions = "AllAwsRegions",
        .aws_regions = "AwsRegions",
    };
};

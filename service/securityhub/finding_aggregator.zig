/// A finding aggregator is a Security Hub resource that specifies cross-Region
/// aggregation settings, including the
/// home Region and any linked Regions.
pub const FindingAggregator = struct {
    /// The ARN of the finding aggregator. You use the finding aggregator ARN to
    /// retrieve details for, update, and delete the finding aggregator.
    finding_aggregator_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .finding_aggregator_arn = "FindingAggregatorArn",
    };
};

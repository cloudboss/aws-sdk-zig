/// Specifies a cross-Region data aggregation configuration, including the
/// aggregation Region and any linked Regions.
pub const AggregatorV2 = struct {
    /// The ARN of the aggregatorV2.
    aggregator_v2_arn: ?[]const u8,

    pub const json_field_names = .{
        .aggregator_v2_arn = "AggregatorV2Arn",
    };
};

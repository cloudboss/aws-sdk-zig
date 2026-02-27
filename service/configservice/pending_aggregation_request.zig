/// An object that represents the account ID and region of an
/// aggregator account that is requesting authorization but is not yet
/// authorized.
pub const PendingAggregationRequest = struct {
    /// The 12-digit account ID of the account requesting to aggregate
    /// data.
    requester_account_id: ?[]const u8,

    /// The region requesting to aggregate data.
    requester_aws_region: ?[]const u8,

    pub const json_field_names = .{
        .requester_account_id = "RequesterAccountId",
        .requester_aws_region = "RequesterAwsRegion",
    };
};

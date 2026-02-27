/// An object that represents the authorizations granted to
/// aggregator accounts and regions.
pub const AggregationAuthorization = struct {
    /// The Amazon Resource Name (ARN) of the aggregation
    /// object.
    aggregation_authorization_arn: ?[]const u8,

    /// The 12-digit account ID of the account authorized to aggregate
    /// data.
    authorized_account_id: ?[]const u8,

    /// The region authorized to collect aggregated data.
    authorized_aws_region: ?[]const u8,

    /// The time stamp when the aggregation authorization was
    /// created.
    creation_time: ?i64,

    pub const json_field_names = .{
        .aggregation_authorization_arn = "AggregationAuthorizationArn",
        .authorized_account_id = "AuthorizedAccountId",
        .authorized_aws_region = "AuthorizedAwsRegion",
        .creation_time = "CreationTime",
    };
};

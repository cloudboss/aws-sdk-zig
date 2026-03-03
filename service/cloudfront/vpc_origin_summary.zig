/// A summary of the CloudFront VPC origin.
pub const VpcOriginSummary = struct {
    /// The account ID of the Amazon Web Services account that owns the VPC origin.
    account_id: ?[]const u8 = null,

    /// The VPC origin summary ARN.
    arn: []const u8,

    /// The VPC origin summary created time.
    created_time: i64,

    /// The VPC origin summary ID.
    id: []const u8,

    /// The VPC origin summary last modified time.
    last_modified_time: i64,

    /// The VPC origin summary name.
    name: []const u8,

    /// The VPC origin summary origin endpoint ARN.
    origin_endpoint_arn: []const u8,

    /// The VPC origin summary status.
    status: []const u8,
};

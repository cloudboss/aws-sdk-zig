const VpcOriginEndpointConfig = @import("vpc_origin_endpoint_config.zig").VpcOriginEndpointConfig;

/// An Amazon CloudFront VPC origin.
pub const VpcOrigin = struct {
    /// The account ID of the Amazon Web Services account that owns the VPC origin.
    account_id: ?[]const u8 = null,

    /// The VPC origin ARN.
    arn: []const u8,

    /// The VPC origin created time.
    created_time: i64,

    /// The VPC origin ID.
    id: []const u8,

    /// The VPC origin last modified time.
    last_modified_time: i64,

    /// The VPC origin status.
    status: []const u8,

    /// The VPC origin endpoint configuration.
    vpc_origin_endpoint_config: VpcOriginEndpointConfig,
};

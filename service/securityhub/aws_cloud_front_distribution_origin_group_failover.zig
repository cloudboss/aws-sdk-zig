const AwsCloudFrontDistributionOriginGroupFailoverStatusCodes = @import("aws_cloud_front_distribution_origin_group_failover_status_codes.zig").AwsCloudFrontDistributionOriginGroupFailoverStatusCodes;

/// Provides information about when an origin group fails over.
pub const AwsCloudFrontDistributionOriginGroupFailover = struct {
    /// Information about the status codes that cause an origin group to fail over.
    status_codes: ?AwsCloudFrontDistributionOriginGroupFailoverStatusCodes = null,

    pub const json_field_names = .{
        .status_codes = "StatusCodes",
    };
};

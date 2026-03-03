const AwsCloudFrontDistributionOriginGroupFailover = @import("aws_cloud_front_distribution_origin_group_failover.zig").AwsCloudFrontDistributionOriginGroupFailover;

/// Information about an origin group for the CloudFront distribution.
pub const AwsCloudFrontDistributionOriginGroup = struct {
    /// Provides the criteria for an origin group to fail over.
    failover_criteria: ?AwsCloudFrontDistributionOriginGroupFailover = null,

    pub const json_field_names = .{
        .failover_criteria = "FailoverCriteria",
    };
};

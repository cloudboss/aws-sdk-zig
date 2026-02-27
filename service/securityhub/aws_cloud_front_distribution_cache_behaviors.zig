const AwsCloudFrontDistributionCacheBehavior = @import("aws_cloud_front_distribution_cache_behavior.zig").AwsCloudFrontDistributionCacheBehavior;

/// Provides information about caching for the CloudFront distribution.
pub const AwsCloudFrontDistributionCacheBehaviors = struct {
    /// The cache behaviors for the distribution.
    items: ?[]const AwsCloudFrontDistributionCacheBehavior,

    pub const json_field_names = .{
        .items = "Items",
    };
};

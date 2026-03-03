const AwsCloudFrontDistributionOriginItem = @import("aws_cloud_front_distribution_origin_item.zig").AwsCloudFrontDistributionOriginItem;

/// A complex type that contains information about origins and origin groups for
/// this CloudFront distribution.
pub const AwsCloudFrontDistributionOrigins = struct {
    /// A complex type that contains origins or origin groups for this distribution.
    items: ?[]const AwsCloudFrontDistributionOriginItem = null,

    pub const json_field_names = .{
        .items = "Items",
    };
};

const AwsCloudFrontDistributionOriginGroup = @import("aws_cloud_front_distribution_origin_group.zig").AwsCloudFrontDistributionOriginGroup;

/// Provides information about origin groups that are associated with the
/// CloudFront distribution.
pub const AwsCloudFrontDistributionOriginGroups = struct {
    /// The list of origin groups.
    items: ?[]const AwsCloudFrontDistributionOriginGroup,

    pub const json_field_names = .{
        .items = "Items",
    };
};

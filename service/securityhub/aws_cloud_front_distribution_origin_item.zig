const AwsCloudFrontDistributionOriginCustomOriginConfig = @import("aws_cloud_front_distribution_origin_custom_origin_config.zig").AwsCloudFrontDistributionOriginCustomOriginConfig;
const AwsCloudFrontDistributionOriginS3OriginConfig = @import("aws_cloud_front_distribution_origin_s3_origin_config.zig").AwsCloudFrontDistributionOriginS3OriginConfig;

/// A complex type that describes the
/// Amazon S3 bucket, HTTP server (for example, a web server), or other server
/// from which CloudFront gets your files.
pub const AwsCloudFrontDistributionOriginItem = struct {
    /// An origin that is not an Amazon S3 bucket, with one exception.
    /// If the Amazon S3 bucket is configured with static website hosting, use this
    /// attribute.
    /// If the Amazon S3 bucket is not configured with static website hosting, use
    /// the `S3OriginConfig` type instead.
    custom_origin_config: ?AwsCloudFrontDistributionOriginCustomOriginConfig,

    /// Amazon S3 origins: The DNS name of the S3 bucket from which you want
    /// CloudFront to get objects for this origin.
    domain_name: ?[]const u8,

    /// A unique identifier for the origin or origin group.
    id: ?[]const u8,

    /// An optional element that causes CloudFront to request your content from a
    /// directory in your Amazon S3 bucket or your custom origin.
    origin_path: ?[]const u8,

    /// An origin that is an S3 bucket that is not configured with static website
    /// hosting.
    s3_origin_config: ?AwsCloudFrontDistributionOriginS3OriginConfig,

    pub const json_field_names = .{
        .custom_origin_config = "CustomOriginConfig",
        .domain_name = "DomainName",
        .id = "Id",
        .origin_path = "OriginPath",
        .s3_origin_config = "S3OriginConfig",
    };
};

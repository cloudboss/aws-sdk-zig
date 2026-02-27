const AwsS3AccountPublicAccessBlockDetails = @import("aws_s3_account_public_access_block_details.zig").AwsS3AccountPublicAccessBlockDetails;
const AwsS3AccessPointVpcConfigurationDetails = @import("aws_s3_access_point_vpc_configuration_details.zig").AwsS3AccessPointVpcConfigurationDetails;

/// Returns configuration information about the specified Amazon S3 access
/// point. S3 access points are named
/// network endpoints that are attached to buckets that you can use to perform
/// S3 object operations.
pub const AwsS3AccessPointDetails = struct {
    /// The Amazon Resource Name (ARN) of the access point.
    access_point_arn: ?[]const u8,

    /// The name or alias of the access point.
    alias: ?[]const u8,

    /// The name of the S3 bucket associated with the specified access point.
    bucket: ?[]const u8,

    /// The Amazon Web Services account ID associated with the S3 bucket associated
    /// with this access point.
    bucket_account_id: ?[]const u8,

    /// The name of the specified access point.
    name: ?[]const u8,

    /// Indicates whether this access point allows access from the public internet.
    network_origin: ?[]const u8,

    public_access_block_configuration: ?AwsS3AccountPublicAccessBlockDetails,

    /// Contains the virtual private cloud (VPC) configuration for the specified
    /// access point.
    vpc_configuration: ?AwsS3AccessPointVpcConfigurationDetails,

    pub const json_field_names = .{
        .access_point_arn = "AccessPointArn",
        .alias = "Alias",
        .bucket = "Bucket",
        .bucket_account_id = "BucketAccountId",
        .name = "Name",
        .network_origin = "NetworkOrigin",
        .public_access_block_configuration = "PublicAccessBlockConfiguration",
        .vpc_configuration = "VpcConfiguration",
    };
};

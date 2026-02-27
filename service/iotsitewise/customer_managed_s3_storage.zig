/// Contains information about a customer managed Amazon S3 bucket.
pub const CustomerManagedS3Storage = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the Identity and Access Management role that allows IoT SiteWise to send data to Amazon S3.
    role_arn: []const u8,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the Amazon S3 object. For more information about how to find the ARN for an
    /// Amazon S3 object, see [Amazon S3
    /// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-arn-format.html) in the
    /// *Amazon Simple Storage Service User Guide*.
    s_3_resource_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "roleArn",
        .s_3_resource_arn = "s3ResourceArn",
    };
};

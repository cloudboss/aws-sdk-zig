const S3AccessPointVpcConfiguration = @import("s3_access_point_vpc_configuration.zig").S3AccessPointVpcConfiguration;

/// Used to create an S3 access point that accepts requests only from a virtual
/// private cloud (VPC) to restrict data access to a private network.
pub const CreateAndAttachS3AccessPointS3Configuration = struct {
    /// Specifies an access policy to associate with the S3 access point
    /// configuration. For more information, see
    /// [Configuring IAM policies for using access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-policies.html)
    /// in the Amazon Simple Storage Service User Guide.
    policy: ?[]const u8,

    /// If included, Amazon S3 restricts access to this S3 access point to requests
    /// made from the specified virtual private cloud (VPC).
    vpc_configuration: ?S3AccessPointVpcConfiguration,

    pub const json_field_names = .{
        .policy = "Policy",
        .vpc_configuration = "VpcConfiguration",
    };
};

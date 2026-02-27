const InternetConfiguration = @import("internet_configuration.zig").InternetConfiguration;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

/// The proposed `InternetConfiguration` or `VpcConfiguration` to apply to the
/// Amazon S3 access point. You can make the access point accessible from the
/// internet, or you can specify that all requests made through that access
/// point must originate from a specific virtual private cloud (VPC). You can
/// specify only one type of network configuration. For more information, see
/// [Creating access
/// points](https://docs.aws.amazon.com/AmazonS3/latest/dev/creating-access-points.html).
pub const NetworkOriginConfiguration = union(enum) {
    /// The configuration for the Amazon S3 access point or multi-region access
    /// point with an `Internet` origin.
    internet_configuration: ?InternetConfiguration,
    vpc_configuration: ?VpcConfiguration,

    pub const json_field_names = .{
        .internet_configuration = "internetConfiguration",
        .vpc_configuration = "vpcConfiguration",
    };
};

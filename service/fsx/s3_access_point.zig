const S3AccessPointVpcConfiguration = @import("s3_access_point_vpc_configuration.zig").S3AccessPointVpcConfiguration;

/// Describes the S3 access point configuration of the S3 access point
/// attachment.
pub const S3AccessPoint = struct {
    /// The S3 access point's alias.
    alias: ?[]const u8 = null,

    /// he S3 access point's ARN.
    resource_arn: ?[]const u8 = null,

    /// The S3 access point's virtual private cloud (VPC) configuration.
    vpc_configuration: ?S3AccessPointVpcConfiguration = null,

    pub const json_field_names = .{
        .alias = "Alias",
        .resource_arn = "ResourceARN",
        .vpc_configuration = "VpcConfiguration",
    };
};

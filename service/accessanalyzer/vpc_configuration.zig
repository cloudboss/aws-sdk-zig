/// The proposed virtual private cloud (VPC) configuration for the Amazon S3
/// access point. VPC configuration does not apply to multi-region access
/// points. For more information, see
/// [VpcConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_VpcConfiguration.html).
pub const VpcConfiguration = struct {
    /// If this field is specified, this access point will only allow connections
    /// from the specified VPC ID.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .vpc_id = "vpcId",
    };
};

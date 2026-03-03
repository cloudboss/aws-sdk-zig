/// The virtual private cloud (VPC) configuration for an Amazon S3 access point.
pub const AwsS3AccessPointVpcConfigurationDetails = struct {
    /// If this field is specified, this access point will only allow connections
    /// from the specified VPC ID.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .vpc_id = "VpcId",
    };
};

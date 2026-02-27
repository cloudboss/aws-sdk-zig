/// If included, Amazon S3 restricts access to this access point to requests
/// from the specified virtual private cloud (VPC).
pub const S3AccessPointVpcConfiguration = struct {
    /// Specifies the virtual private cloud (VPC) for the S3 access point VPC
    /// configuration, if one exists.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .vpc_id = "VpcId",
    };
};

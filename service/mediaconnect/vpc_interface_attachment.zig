/// The settings for attaching a VPC interface to an resource.
pub const VpcInterfaceAttachment = struct {
    /// The name of the VPC interface to use for this resource.
    vpc_interface_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .vpc_interface_name = "VpcInterfaceName",
    };
};

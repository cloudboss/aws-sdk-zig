/// Identifies a network interface for the Amazon EC2 instance.
pub const AwsEc2InstanceNetworkInterfacesDetails = struct {
    /// The identifier of the network interface. The details are in a corresponding
    /// `AwsEc2NetworkInterfacesDetails` object.
    network_interface_id: ?[]const u8,

    pub const json_field_names = .{
        .network_interface_id = "NetworkInterfaceId",
    };
};

/// Describes a network interface.
pub const NetworkInterface = struct {
    /// The ID of the network interface.
    network_interface_id: ?[]const u8 = null,

    /// The ID of the subnet.
    subnet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .network_interface_id = "networkInterfaceId",
        .subnet_id = "subnetId",
    };
};

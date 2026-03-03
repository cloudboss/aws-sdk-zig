/// An elastic network interface (ENI) that connects hosts to the VLAN subnets.
/// Amazon EVS provisions two identically configured ENIs in the VMkernel
/// management subnet during host creation. One ENI is active, and the other is
/// in standby mode for automatic switchover during a failure scenario.
pub const NetworkInterface = struct {
    /// The unique ID of the elastic network interface.
    network_interface_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .network_interface_id = "networkInterfaceId",
    };
};

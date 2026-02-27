/// The container for the network interface.
pub const NetworkInterface = struct {
    /// The ID for the network interface.
    network_interface_id: ?[]const u8,

    pub const json_field_names = .{
        .network_interface_id = "NetworkInterfaceId",
    };
};

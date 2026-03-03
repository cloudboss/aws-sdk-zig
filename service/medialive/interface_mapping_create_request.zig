/// Used in ClusterNetworkSettingsCreateRequest.
pub const InterfaceMappingCreateRequest = struct {
    /// The logical name for one interface (on every Node) that handles a specific
    /// type of traffic. We recommend that the name hints at the physical interface
    /// it applies to. For example, it could refer to the traffic that the physical
    /// interface handles. For example, my-Inputs-Interface.
    logical_interface_name: ?[]const u8 = null,

    /// The ID of the network that you want to connect to the specified
    /// logicalInterfaceName.
    network_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .logical_interface_name = "LogicalInterfaceName",
        .network_id = "NetworkId",
    };
};

const InterfaceMappingCreateRequest = @import("interface_mapping_create_request.zig").InterfaceMappingCreateRequest;

/// Used in a CreateClusterRequest.
pub const ClusterNetworkSettingsCreateRequest = struct {
    /// Specify one network interface as the default route for traffic to and from
    /// the Node. MediaLive Anywhere uses this default when the destination for the
    /// traffic isn't covered by the route table for any of the networks. Specify
    /// the value of the appropriate logicalInterfaceName parameter that you create
    /// in the interfaceMappings.
    default_route: ?[]const u8 = null,

    /// An array of interfaceMapping objects for this Cluster. You must create a
    /// mapping for node interfaces that you plan to use for encoding traffic. You
    /// typically don't create a mapping for the management interface. You define
    /// this mapping in the Cluster so that the mapping can be used by all the
    /// Nodes. Each mapping logically connects one interface on the nodes with one
    /// Network. Each mapping consists of a pair of parameters. The
    /// logicalInterfaceName parameter creates a logical name for the Node interface
    /// that handles a specific type of traffic. For example, my-Inputs-Interface.
    /// The networkID parameter refers to the ID of the network. When you create the
    /// Nodes in this Cluster, you will associate the logicalInterfaceName with the
    /// appropriate physical interface.
    interface_mappings: ?[]const InterfaceMappingCreateRequest = null,

    pub const json_field_names = .{
        .default_route = "DefaultRoute",
        .interface_mappings = "InterfaceMappings",
    };
};

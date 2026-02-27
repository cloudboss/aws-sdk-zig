const InterfaceMappingUpdateRequest = @import("interface_mapping_update_request.zig").InterfaceMappingUpdateRequest;

/// Placeholder documentation for ClusterNetworkSettingsUpdateRequest
pub const ClusterNetworkSettingsUpdateRequest = struct {
    /// Include this parameter only if you want to change the default route for the
    /// Cluster. Specify one network interface as the default route for traffic to
    /// and from the node. MediaLive Anywhere uses this default when the destination
    /// for the traffic isn't covered by the route table for any of the networks.
    /// Specify the value of the appropriate logicalInterfaceName parameter that you
    /// create in the interfaceMappings.
    default_route: ?[]const u8,

    /// An array of interfaceMapping objects for this Cluster. Include this
    /// parameter only if you want to change the interface mappings for the Cluster.
    /// Typically, you change the interface mappings only to fix an error you made
    /// when creating the mapping. In an update request, make sure that you enter
    /// the entire set of mappings again, not just the mappings that you want to add
    /// or change. You define this mapping so that the mapping can be used by all
    /// the Nodes. Each mapping logically connects one interface on the nodes with
    /// one Network. Each mapping consists of a pair of parameters. The
    /// logicalInterfaceName parameter creates a logical name for the Node interface
    /// that handles a specific type of traffic. For example, my-Inputs-Interface.
    /// The networkID parameter refers to the ID of the network. When you create the
    /// Nodes in this Cluster, you will associate the logicalInterfaceName with the
    /// appropriate physical interface.
    interface_mappings: ?[]const InterfaceMappingUpdateRequest,

    pub const json_field_names = .{
        .default_route = "DefaultRoute",
        .interface_mappings = "InterfaceMappings",
    };
};

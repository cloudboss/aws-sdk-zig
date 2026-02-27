const InterfaceMapping = @import("interface_mapping.zig").InterfaceMapping;

/// Used in DescribeClusterResult, DescribeClusterSummary, UpdateClusterResult.
pub const ClusterNetworkSettings = struct {
    /// The network interface that is the default route for traffic to and from the
    /// node. MediaLive Anywhere uses this default when the destination for the
    /// traffic isn't covered by the route table for any of the networks. Specify
    /// the value of the appropriate logicalInterfaceName parameter that you create
    /// in the interfaceMappings.
    default_route: ?[]const u8,

    /// An array of interfaceMapping objects for this Cluster. Each mapping
    /// logically connects one interface on the nodes with one Network. You need
    /// only one mapping for each interface because all the Nodes share the mapping.
    interface_mappings: ?[]const InterfaceMapping,

    pub const json_field_names = .{
        .default_route = "DefaultRoute",
        .interface_mappings = "InterfaceMappings",
    };
};

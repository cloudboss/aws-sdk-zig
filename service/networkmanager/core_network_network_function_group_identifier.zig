/// Describes a core network
pub const CoreNetworkNetworkFunctionGroupIdentifier = struct {
    /// The ID of the core network.
    core_network_id: ?[]const u8 = null,

    /// The location for the core network edge.
    edge_location: ?[]const u8 = null,

    /// The network function group name.
    network_function_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .core_network_id = "CoreNetworkId",
        .edge_location = "EdgeLocation",
        .network_function_group_name = "NetworkFunctionGroupName",
    };
};

pub const DBProxyEndpointStatus = enum {
    available,
    modifying,
    incompatible_network,
    insufficient_resource_limits,
    creating,
    deleting,
};

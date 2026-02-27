pub const DBProxyStatus = enum {
    available,
    modifying,
    incompatible_network,
    insufficient_resource_limits,
    creating,
    deleting,
    suspended,
    suspending,
    reactivating,
};

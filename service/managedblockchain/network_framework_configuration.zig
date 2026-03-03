const NetworkFabricConfiguration = @import("network_fabric_configuration.zig").NetworkFabricConfiguration;

/// Configuration properties relevant to the network for the blockchain
/// framework that the network uses.
pub const NetworkFrameworkConfiguration = struct {
    /// Hyperledger Fabric configuration properties for a Managed Blockchain network
    /// that uses Hyperledger Fabric.
    fabric: ?NetworkFabricConfiguration = null,

    pub const json_field_names = .{
        .fabric = "Fabric",
    };
};

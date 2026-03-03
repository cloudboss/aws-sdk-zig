const NetworkEthereumAttributes = @import("network_ethereum_attributes.zig").NetworkEthereumAttributes;
const NetworkFabricAttributes = @import("network_fabric_attributes.zig").NetworkFabricAttributes;

/// Attributes relevant to the network for the blockchain framework that the
/// network uses.
pub const NetworkFrameworkAttributes = struct {
    /// Attributes of an Ethereum network for Managed Blockchain resources
    /// participating in an Ethereum network.
    ethereum: ?NetworkEthereumAttributes = null,

    /// Attributes of Hyperledger Fabric for a Managed Blockchain network that uses
    /// Hyperledger Fabric.
    fabric: ?NetworkFabricAttributes = null,

    pub const json_field_names = .{
        .ethereum = "Ethereum",
        .fabric = "Fabric",
    };
};

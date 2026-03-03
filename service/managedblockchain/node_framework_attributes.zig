const NodeEthereumAttributes = @import("node_ethereum_attributes.zig").NodeEthereumAttributes;
const NodeFabricAttributes = @import("node_fabric_attributes.zig").NodeFabricAttributes;

/// Attributes relevant to a node on a Managed Blockchain network for the
/// blockchain framework that the network uses.
pub const NodeFrameworkAttributes = struct {
    /// Attributes of Ethereum for a node on a Managed Blockchain network that uses
    /// Ethereum.
    ethereum: ?NodeEthereumAttributes = null,

    /// Attributes of Hyperledger Fabric for a peer node on a Managed Blockchain
    /// network that uses Hyperledger Fabric.
    fabric: ?NodeFabricAttributes = null,

    pub const json_field_names = .{
        .ethereum = "Ethereum",
        .fabric = "Fabric",
    };
};

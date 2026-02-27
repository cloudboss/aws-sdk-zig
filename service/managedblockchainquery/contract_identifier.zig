const QueryNetwork = @import("query_network.zig").QueryNetwork;

/// Container for the blockchain address and network information about a
/// contract.
pub const ContractIdentifier = struct {
    /// Container for the blockchain address about a contract.
    contract_address: []const u8,

    /// The blockchain network of the contract.
    network: QueryNetwork,

    pub const json_field_names = .{
        .contract_address = "contractAddress",
        .network = "network",
    };
};

const QueryNetwork = @import("query_network.zig").QueryNetwork;
const QueryTokenStandard = @import("query_token_standard.zig").QueryTokenStandard;

/// The contract or wallet address by which to filter the request.
pub const ContractFilter = struct {
    /// The network address of the deployer.
    deployer_address: []const u8,

    /// The blockchain network of the contract.
    network: QueryNetwork,

    /// The container for the token standard.
    token_standard: QueryTokenStandard,

    pub const json_field_names = .{
        .deployer_address = "deployerAddress",
        .network = "network",
        .token_standard = "tokenStandard",
    };
};

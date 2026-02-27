const QueryNetwork = @import("query_network.zig").QueryNetwork;

/// The container of the token filter like the contract address
/// on a given blockchain network or a unique token identifier on a given
/// blockchain network.
///
/// You must always specify the network property of this
/// container when using this operation.
pub const TokenFilter = struct {
    /// This is the address of the contract.
    contract_address: ?[]const u8,

    /// The blockchain network of the token.
    network: QueryNetwork,

    /// The unique identifier of the token.
    token_id: ?[]const u8,

    pub const json_field_names = .{
        .contract_address = "contractAddress",
        .network = "network",
        .token_id = "tokenId",
    };
};

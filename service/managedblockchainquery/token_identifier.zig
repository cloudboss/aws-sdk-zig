const QueryNetwork = @import("query_network.zig").QueryNetwork;

/// The container for the identifier for the token including the unique token ID
/// and its blockchain network.
///
/// Only the native tokens BTC and ETH, and the ERC-20,
/// ERC-721, and ERC 1155 token standards are supported.
pub const TokenIdentifier = struct {
    /// This is the token's contract address.
    contract_address: ?[]const u8 = null,

    /// The blockchain network of the token.
    network: QueryNetwork,

    /// The unique identifier of the token.
    ///
    /// For native tokens, use the 3 character abbreviation that best matches your
    /// token.
    /// For example, btc for Bitcoin, eth for Ether, etc. For all other token types
    /// you must
    /// specify the `tokenId` in the 64 character hexadecimal `tokenid` format.
    token_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .contract_address = "contractAddress",
        .network = "network",
        .token_id = "tokenId",
    };
};

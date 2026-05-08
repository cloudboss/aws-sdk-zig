const BlockchainChainId = @import("blockchain_chain_id.zig").BlockchainChainId;
const CryptoWalletNetwork = @import("crypto_wallet_network.zig").CryptoWalletNetwork;
const InstrumentBalanceToken = @import("instrument_balance_token.zig").InstrumentBalanceToken;

/// A single token balance entry
pub const TokenBalance = struct {
    /// Raw balance in the smallest denomination (e.g., USDC base units where 1 USDC
    /// = 1000000).
    amount: []const u8,

    /// The specific blockchain chain.
    chain: BlockchainChainId,

    /// Number of decimal places for the token (e.g., 6 for USDC).
    decimals: i32,

    /// The blockchain network family (ETHEREUM or SOLANA).
    network: CryptoWalletNetwork,

    /// The supported token for this balance.
    token: InstrumentBalanceToken,

    pub const json_field_names = .{
        .amount = "amount",
        .chain = "chain",
        .decimals = "decimals",
        .network = "network",
        .token = "token",
    };
};
